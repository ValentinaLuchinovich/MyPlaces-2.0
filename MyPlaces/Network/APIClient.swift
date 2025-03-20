//
//  APIClient.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 19.03.2025.
//

import Foundation

public typealias SendRequestCompletion<ResultType: Decodable> = (APIResponse<ResultType>) -> ()

extension Notification.Name {
    static let authError = NSNotification.Name("errorAuthCatched")
}

public final class APIClient: NSObject {
    
    // MARK: Properties
    
    public static let shared = APIClient()
    
    /// Замыкание, которое срабатывает при получении ошибки timeOut
    var timeOutHandler: () -> () = { }
    
    private let accessToken = ""
    private let refreshToken = ""

    private var refreshTokenIsCalled = false
    
    /// Запросы, которые получили ошибку, но их нужно позже снова отправить на сервер
    private var errorTasksHandlers: [() async throws -> (ErrorResponseAPIModel)] = []
    /// Каждые 5 секунд запускает повторно запросы, которые вернули 401 или timedOut
    private var executeErrorTasksTimer: Timer = Timer()
    
    // MARK: Initialization
    
    private override init() {
        super.init()
        Task(priority: .background) {
            self.executeErrorTasksTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                Task(priority: .background) {
                    try await self.executeErrorTasks()
                }
            }
        }
    }
    
    /// Отправка запроса на сервер
    public func sendRequest<EndpointType: APIEndpoint, ResultType: Decodable>(
        request: APIRequest<EndpointType>,
        isData: Bool = false) async throws -> ResultType {
            
            let requestDescription = "Запрос \(request.endpoint.method.rawValue) \(request.endpoint.path)."
            LogService.print(message: "\(requestDescription) Отправлен на сервер.", type: .error)
            
            let session = URLSession(configuration: createConfiguration(), delegate: self, delegateQueue: nil)
            
            guard let urlRequest = self.createURLRequest(for: request) else {
                let errorMessage = "\(requestDescription) Не удалось создать URLRequest."
                LogService.print(message: errorMessage, type: .error)
                let errorModel = ErrorResponseAPIModel(message: errorMessage)
                throw errorModel
            }
            do {
                let (data, response) = try await session.data(for: urlRequest)
                return try await self.handleDataTaskResponse(
                    data: data,
                    response: response,
                    error: nil,
                    request: request,
                    isData: isData,
                    requestDescription: requestDescription)
            } catch {
                throw handleURLError(
                    error: error,
                    request: request,
                    isData: isData,
                    requestDescription: requestDescription)
            }
        }
    
    func executeErrorTasks() async throws {
        while !errorTasksHandlers.isEmpty {
            let errorTaskHandler = errorTasksHandlers.removeFirst()
            throw try await errorTaskHandler()
        }
    }
}

// MARK: URLSessionDelegate

extension APIClient: URLSessionDelegate { }

// MARK: Private methods

// swiftlint:disable function_parameter_count
private extension APIClient {
    
    func createURLRequest<EndpointType: APIEndpoint>(
        for request: APIRequest<EndpointType>) -> URLRequest? {
        // Формируем queryItems для запроса
        let queryItems = createQueryItems(from: request.query)
        
        // Формируем URL
        let url = request.endpoint.host.rawValue + request.endpoint.path
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = urlComponents?.url else { return nil }
        
        // Создаем URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.endpoint.method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        urlRequest.timeoutInterval = 60.0
        if let params = request.body {
            do {
                let body = try params.rawData()
                urlRequest.httpBody = body
            } catch {
                print("Error making body: \(error)")
            }
        }
        
        return urlRequest
    }
    
    func createQueryItems(from query: [String: Any]) -> [URLQueryItem] {
        return query.compactMap { key, value in
            if let strValue = getStringValue(from: value) {
                return URLQueryItem(name: key, value: strValue)
            }
            return nil
        }
    }
    
    func getStringValue(from value: Any) -> String? {
        switch value {
            case let stringValue as String:
                return stringValue
            case let intValue as Int:
                return String(intValue)
            case let doubleValue as Double:
                return String(doubleValue)
            case let boolValue as Bool:
                return String(boolValue)
            default:
                return nil
        }
    }
    
    func createConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        configuration.timeoutIntervalForRequest = 30
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = true
        }
        
        return configuration
    }
    
    func handleDataTaskResponse<EndpointType: APIEndpoint, ResultType: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        request: APIRequest<EndpointType>,
        isData: Bool,
        requestDescription: String
    ) async throws -> ResultType {
        
        if let error = error {
            throw handleURLError(
                    error: error,
                    request: request,
                    isData: isData,
                    requestDescription: requestDescription)
        }

        guard let data = data else {
            throw handleEmptyData(requestDescription: requestDescription)
        }
        
        guard let response = response as? HTTPURLResponse else {
            throw handleEmptyResponse(requestDescription: requestDescription)
        }
        
        if Array(200...299).contains(response.statusCode) {
            return try await handleSuccessfulResponse(
                data: data,
                response: response,
                request: request,
                isData: isData,
                requestDescription: requestDescription
            )
        } else if response.statusCode == 500 || response.statusCode == 401 {
            await MainActor.run {
                #warning("Добавить показ экрана об ошибке")
                //ErrorManager.shared.topViewController(errorViewController: ErrorViewController())
            }
            throw handleErrorResponse(
                data: data,
                response: response,
                requestDescription: requestDescription
            )
        }
        else {
            throw handleErrorResponse(
                data: data,
                response: response,
                requestDescription: requestDescription
            )
        }
    }
    
    func handleURLError<EndpointType: APIEndpoint>(
        error: Error,
        request: APIRequest<EndpointType>,
        isData: Bool,
        requestDescription: String
    ) -> ErrorResponseAPIModel {
        if let error = error as? URLError, error.code == .timedOut {
            Task(priority: .background) {
                self.errorTasksHandlers.append({
                    try await self.sendRequest(request: request, isData: isData)
                })
                
                await MainActor.run {
                    self.timeOutHandler()
                }
            }
        }
        
        let errorMessage = "\(requestDescription) Ошибка dataTask. " + error.localizedDescription
        LogService.print(message: errorMessage, type: .error)
        let errorModel = ErrorResponseAPIModel(message: (error as? ErrorResponseAPIModel)?.message ?? "")
        
        return errorModel
    }
    
    func handleEmptyData(
        requestDescription: String
    ) -> ErrorResponseAPIModel {
        let errorMessage = "\(requestDescription) Пустой ответ (Empty data)."
        LogService.print(message: errorMessage, type: .error)
        let errorModel = ErrorResponseAPIModel(message: errorMessage)
        return errorModel
    }
    
    func handleEmptyResponse(
        requestDescription: String
    ) -> ErrorResponseAPIModel {
        let errorMessage = "\(requestDescription) Пустой ответ (Empty response)."
        LogService.print(message: errorMessage, type: .error)
        let errorModel = ErrorResponseAPIModel(message: errorMessage, errors: nil)
        return errorModel
    }
    
    func handleSuccessfulResponse<EndpointType: APIEndpoint, ResultType: Decodable>(
        data: Data,
        response: HTTPURLResponse,
        request: APIRequest<EndpointType>,
        isData: Bool,
        requestDescription: String
    ) async throws -> ResultType {
        guard !(ResultType.self is NoneResult.Type) else {
            LogService.print(message: "\(requestDescription) Успешно выполнен. Получен пустой ответ", type: .error)
            return NoneResult() as! ResultType
        }
        
        do {
            let successResponse = try JSONDecoder().decode(ResultType.self, from: data)
            LogService.print(message: "\(requestDescription) Успешно выполнен.", type: .error)
            return successResponse
        }
        catch let jsonDecoderError {
            let jsonDecoderErrorString = self.jsonDecoderErrorToString(jsonDecoderError)
            let errorMessage = "\(requestDescription)"
            + " Не удалось распарсить "
            + "\(String(describing: type(of: ResultType.self))). \(jsonDecoderErrorString)"
            LogService.print(message: errorMessage, type: .error)
            let errorModel = ErrorResponseAPIModel(message: errorMessage)
            throw errorModel
        }
    }
    
    func handleErrorResponse(
        data: Data,
        response: HTTPURLResponse,
        requestDescription: String
    ) -> ErrorResponseAPIModel {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponseAPIModel.self, from: data)
            let errorMessage = "\(requestDescription) Ошибка \(response.statusCode) - \(errorResponse.message)"
            LogService.print(message: errorMessage, type: .error)
            return errorResponse
        } catch let jsonDecoderError {
            let jsonDecoderErrorString = self.jsonDecoderErrorToString(jsonDecoderError)
            let errorMessage = """
            \(requestDescription) Не удалось распарсить ErrorResponseAPIModel. \(jsonDecoderErrorString)
            """
            LogService.print(message: errorMessage, type: .error)
            let errorModel = ErrorResponseAPIModel(message: errorMessage)
            return errorModel
        }
    }
    
    func jsonDecoderErrorToString(_ error: Error) -> String {
        switch error {
            case DecodingError.dataCorrupted(let context):
                LogService.print(message: String(describing: context), type: .error)
                return String(describing: context)
            case DecodingError.keyNotFound(let key, let context):
                LogService.print(
                    message: "Key '\(key.stringValue)' not found: \(context.debugDescription)",
                    type: .error
                )
                LogService.print(message: "codingPath: \(context.codingPath)", type: .error)
                return "Не найдено поле '\(key.stringValue)'. "
                + "Путь: \(context.codingPath.map { $0.stringValue }.joined(separator: "->")). "
                + "Подробнее: \(context.debugDescription)"
            case DecodingError.valueNotFound(let value, let context):
                LogService.print(message: "Value '\(value)' not found: \(context.debugDescription)", type: .error)
                LogService.print(message: "codingPath: \(context.codingPath)", type: .error)
                let fieldName = context.codingPath.last?.stringValue ?? "---"
                let path = context.codingPath.map { $0.stringValue }.joined(separator: "->")
                return "Не найдено значение \(value) у поля '\(fieldName)'. "
                + "Путь: \(path). "
                + "Подробнее: \(context.debugDescription)"
            case DecodingError.typeMismatch(let type, let context):
                LogService.print(message: "Type '\(type)' mismatch: \(context.debugDescription)", type: .error)
                LogService.print(message: "codingPath: \(context.codingPath)", type: .error)
                let fieldName = context.codingPath.last?.stringValue ?? "---"
                let path = context.codingPath.map { $0.stringValue }.joined(separator: "->")
                return "Неверный тип \(type) у поля '\(fieldName)'. "
                + "Путь: \(path). "
                + "Подробнее: \(context.debugDescription)"
            default:
                LogService.print(message: "error: \(error.localizedDescription)", type: .error)
                return error.localizedDescription
        }
    }
}


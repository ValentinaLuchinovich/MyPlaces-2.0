//
//  UIImageView + downloadImage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 26.03.2025.
//

import UIKit
import Kingfisher
import KingfisherWebP

extension UIImageView{
    
    func downloadImage(
        urlString: String?,
        scrollToTop: Bool = false,
        useDefaultImage: Bool = true,
        completion: @escaping (Bool)->() = { _ in }
    ) {
        guard let url = URL(string: urlString ?? "") else {
            image = useDefaultImage ? UIImage(named: "AppIcon") : nil
            LogService.print(message: "Error image load from url: \(urlString ?? "url is undefined")")
            completion(false)
            return
        }
        let processor: ImageProcessor = urlString!.contains(".webp") ? WebPProcessor() : DefaultImageProcessor()
        kf.indicatorType = .activity
        KingfisherManager.shared.downloader.downloadTimeout = 60
        kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.5)),
            ],
            progressBlock: { receivedSize, totalSize in },
            completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Success KF image: \(value)")
                    completion(true)
                case .failure(let error):
                    print(error)
                    self.image = useDefaultImage ? UIImage(named: "plug") : nil
                    completion(false)
                }
            }
        )
    }
}
    

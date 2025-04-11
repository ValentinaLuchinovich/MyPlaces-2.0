//
//  ProfileViewController.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 04.03.2025.
//

import UIKit
import Combine

final class ProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let photoSize: CGFloat = 120
        static let cornerRadius: CGFloat = 60
        static let buttonWidth: CGFloat = 120
        static let buttonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 5
    }
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: ProfileViewModel
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.borderWidth = Constants.borderWidth
        imageView.layer.borderColor = UIColor.orangeDark.cgColor
        imageView.backgroundColor = .systemGray5
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppLocalizable.addPhoto, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orangeDark
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindings()
        viewModel.loadSavedImage()
    }
}

// MARK: - Private Methods

private extension ProfileViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        view.addSubview(addPhotoButton)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
            make.size.equalTo(Constants.photoSize)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(AppConstants.largePadding)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.buttonWidth)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
    func bindings() {
        viewModel.$profileImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.profileImageView.image = image
            }
            .store(in: &cancellables)
        
        viewModel.$isImagePickerPresented
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPresented in
                if isPresented {
                    self?.presentImagePicker()
                }
            }
            .store(in: &cancellables)
    }
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func addPhotoTapped() {
        viewModel.selectPhoto()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            viewModel.updateProfileImage(editedImage)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


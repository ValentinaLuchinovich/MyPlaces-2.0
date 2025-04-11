import UIKit
import Combine

final class ProfileViewModel {
    
    // MARK: - Published properties
    
    @Published var profileImage: UIImage?
    @Published var isImagePickerPresented = false
    
    // MARK: - Internal methods
    
    func selectPhoto() {
        isImagePickerPresented = true
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImage = image
        saveImageToUserDefaults(image)
    }
    
    func loadSavedImage() {
        if let imageData = LocalStorage.profilePhoto,
           let image = UIImage(data: imageData) {
            profileImage = image
        }
    }
} 

// MARK: Private

private extension ProfileViewModel {
    func saveImageToUserDefaults(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            LocalStorage.profilePhoto = imageData
        }
    }
}

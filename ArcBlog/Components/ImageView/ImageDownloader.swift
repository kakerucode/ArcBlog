//
//  ImageDownloader.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import Foundation
import UIKit

@Observable
class ImageDownloader {
    var image: UIImage?
    private(set) var isLoading: Bool = false
    private var task: Task<Void, Never>? = nil
    private let dataSizeThreshold: Int = 1024 * 200
    private let compressImageSize: CGSize = CGSize(width: 160, height: 90)
    
    func loadImage(from url: URL) {
        if let cacheImage: UIImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            image = cacheImage
            return
        }
        image = nil
        isLoading = true
        task = Task {
            do {
                let (data, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
                
                if var downloadedImage: UIImage = UIImage(data: data) {
//                    downloadedImage = downloadedImage.compressImage(withTargetSize: dataSizeThreshold)
                    downloadedImage = compressImageSize(image: downloadedImage)
                    ImageCache.shared.setImage(downloadedImage, forKey: url.absoluteString)
                    image = downloadedImage
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
            isLoading = false
        }
    }
    
    // "https://www.arcblock.io/blog/uploads/www-blog-images/2020-05-11-future-of-work-hackathon-recap/cover.jpg"     
    func cancel() {
        task?.cancel()
        isLoading = false
    }
    
    private func compressImageSize(image: UIImage) -> UIImage {
        if image.size.width > compressImageSize.width {
            let targetHeight: CGFloat =  floor(compressImageSize.width / image.size.width * image.size.height)
            return resizeImage(image: image, targetSize: CGSize(width: compressImageSize.width, height: targetHeight))
        }
        return image
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

}

fileprivate extension UIImage {
    func compressImage(withTargetSize targetSize: Int) -> UIImage {
        guard var currentData: Data = jpegData(compressionQuality: 1) else { return self }
        var maxQuality: CGFloat = 1.0
        let minQuality: CGFloat = 0.0
        while currentData.count > targetSize {
            let compressQuality = (maxQuality + minQuality) / 2
            guard let newData: Data = jpegData(compressionQuality: compressQuality) else { return self }
            currentData = newData
            if currentData.count > targetSize {
                maxQuality = compressQuality
            } else {
                return UIImage(data: currentData) ?? self
            }
        }
        return self
    }
}

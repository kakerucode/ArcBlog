//
//  ImageCache.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import Foundation
import UIKit

struct ImageCache {
    static let shared: ImageCache = ImageCache()
    
    private let cache: NSCache<NSString, UIImage> = {
        let cache: NSCache<NSString, UIImage> = NSCache()
        cache.name = "AsyncImageCache"
        cache.countLimit = 1000
        cache.totalCostLimit = 1024 * 1024 * 100 // maximum 100MB
        return cache
    }()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}

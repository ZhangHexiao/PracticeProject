//
//  ImageCacheLoader.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class ImageCacheLoader {
    private static let shared = ImageCacheLoader()
    private var cache: NSCache<NSString, UIImage>
    
    private init() {
        cache = NSCache()
    }
    
    static func clearCache() {
        shared.cache.removeAllObjects()
    }
    
    static func requestImage(imageUrl: String, completion: @escaping (Result<UIImage, NetworkError>)->Void) {
        if let image = shared.cache.object(forKey: imageUrl as NSString) {
            completion(.success(image))
        } else {
            NetworkManager.shared.executeRequest(apiRequest: ImageDownLoadRequest(url: imageUrl)){result in
                
                switch result {
                case .success(let imageData):
                    let image = UIImage(data: imageData)
                    if let image {
                        shared.cache.setObject(image, forKey: imageUrl as NSString)
                    }
                    completion(.success(image ?? UIImage()))
                case .failure(_):
                    completion(.failure(NetworkError.imageDownloadingFailure))
                }
            }
        }
    }
}


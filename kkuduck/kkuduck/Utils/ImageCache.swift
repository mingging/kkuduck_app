//
//  ImageCache.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import UIKit
import Alamofire

final class ImageCache {

    private static let cachedImages = NSCache<NSString, UIImage>()

    static func load(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if urlString.isEmpty {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        if let cachedImage = cachedImages.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        DispatchQueue.global(qos: .background).async {
            AF.download(urlString).responseData(queue: .main) { response in
                guard let data = response.value, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
                self.cachedImages.setObject(image, forKey: urlString as NSString)
            }
        }
    }

}

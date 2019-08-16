//
//  ImageCachingService.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-14.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit
class ImageCachingService{
    static func dowmnloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?)->()){
        let dataTask = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            var downloadedImage: UIImage?
            if let data = data{
                downloadedImage = UIImage(data: data)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
    dataTask.resume()
    }
}

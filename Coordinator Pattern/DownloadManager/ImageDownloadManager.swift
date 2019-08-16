//
//  ImageDownloadManager.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-14.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit
typealias ImgedownloadHandler = (_ image: UIImage?, _ url: URL, _ indexpath: IndexPath?, _ error: Error?)-> Void

final class ImageDownloadManager{
    private var completionHandler: ImgedownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Alkaida image download" 
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageDownloadManager()
    private init(){
    }
    
    func downloadImage(_ character: Character, indexPath: IndexPath?, handler: @escaping ImgedownloadHandler){
        self.completionHandler = handler
        guard let url = URL(string: character.image) else{ return
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString){
            print("The images are already cached")
            self.completionHandler?(cachedImage, url, indexPath, nil)
        }else
        {
            if let operations = (imageDownloadQueue.operations as? [ImageDownloadOperation])?.filter({ $0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true}), let operation = operations.first{
                print("There is already operation running with this url")
                operation.queuePriority = .high
            }else{
                print("let start new operation")
                let operation = ImageDownloadOperation(url: url, indexPath: indexPath)
                if indexPath == nil{
                    operation.queuePriority = .veryHigh
                }
                operation.downloadHandler = {(image, url, indexPath, err) in
                    if let newImage = image{
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image, url, indexPath, err)
                }
                imageDownloadQueue.addOperation(operation)
            }
            
        }
        
    }
    func slowDownImageDownloadTaskPriority(character: Character){
        guard let url = URL(string: character.image)else{return}
        
        if let operations = (imageDownloadQueue.operations as? [ImageDownloadOperation])?.filter({ $0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true}), let operation = operations.first{
            print("slow down the priority of \(url)")
            operation.queuePriority = .low
        }
    }
    
    func cancellAll(){
        imageDownloadQueue.cancelAllOperations()
    }
}

//
//  ImageDownloadOperation.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-15.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class ImageDownloadOperation: Operation{
    var downloadHandler: ImgedownloadHandler?
    var imageUrl: URL!
    private  var indexPath: IndexPath?
    
    override var isAsynchronous: Bool{
        get{
            return true
        }
    }
    private var _executing = false{
        willSet{
            willChangeValue(forKey: "isExecuting")
        }
        didSet{
            didChangeValue(forKey: "isExecuting")
        }
    }
    override var isExecuting: Bool{
        return _executing
    }
    private var _finished = false{
        willSet{
            willChangeValue(forKey: "isFinished")
        }
        didSet{
            didChangeValue(forKey: "isFinished")
        }
    }
    override var isFinished: Bool{
        return _finished
    }
    func executing(_ executing: Bool){
        _executing = executing
    }
    func finished(_ finished: Bool){
        _finished = finished
    }
    
    required init(url: URL, indexPath: IndexPath?) {
        self.imageUrl = url
        self.indexPath = indexPath
    }
    
    override func main() {
        guard isCancelled == false else {
            finished(true)
            return
        }
        self.executing(true)
        self.downloadImageFromUrl()
    }
    
    
    func downloadImageFromUrl(){
        let downloadSession = URLSession.shared
        let downloadTask = downloadSession.downloadTask(with: self.imageUrl) { (retrievedUrl, resp, err) in
            if let retrievedUrl =  retrievedUrl, let data = try? Data(contentsOf: retrievedUrl){
                let downloadedImage = UIImage(data: data)
                self.downloadHandler?(downloadedImage, self.imageUrl, self.indexPath, err)
            }
            self.finished(true)
            self.executing(false)
        }
        downloadTask.resume()
    }
}

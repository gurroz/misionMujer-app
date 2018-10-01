//
//  MediaDownloadService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import UIKit

final class MediaDownloadService: NSObject {
    private var session: URLSession!
    
    public static let shared = MediaDownloadService()
    
    private override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
//    func download(request: URLRequest) -> DownloadTask {
//        let task = session.dataTask(with: request)
//        let downloadTask = GenericDownloadTask(task: task)
//        downloadTasks.append(downloadTask)
//        return downloadTask
//    }
}

extension MediaDownloadService: URLSessionDataDelegate {
    
    internal func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        // Calls background session completion in AppDelegate
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let completionHandler = appDelegate.backgroundSessionCompletionHandler {
            appDelegate.backgroundSessionCompletionHandler = nil
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64,totalBytesExpectedToWrite: Int64) {
        // Gives you the URLSessionDownloadTask that is being executed
        // along with the total file length - totalBytesExpectedToWrite
        // and the current amount of data that has received up to this point - totalBytesWritten
    }
}

//
//  MediaDownloadService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import UIKit

class DownloadTeaching {
    var teaching: Teaching
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    var onSuccess: (Teaching) -> ()
    var onError: (String) -> ()
    var onUpdate: (Float) -> ()
    var progress: Float = 0
    
    init(teaching: Teaching, onSuccess: @escaping (Teaching) -> (), onError: @escaping (String) -> (), onUpdate: @escaping (Float) -> ()) {
        self.teaching = teaching
        self.onError = onError
        self.onUpdate = onUpdate
        self.onSuccess = onSuccess
    }
}

final class MediaDownloadService: NSObject {
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    var dataTasks: [URL: DownloadTeaching] = [:]

    public static let shared = MediaDownloadService()
    
    private override init() {
        super.init()
    }
    
    func download(teaching: Teaching, onSuccess: @escaping (Teaching) -> (), onError: @escaping (String) -> (), onUpdate: @escaping (Float) -> ()) {
        print("Starting download")
        guard let url = URL(string: teaching.media) else { return }
        let urlReq = URLRequest(url: url)
        
        let downloadTeaching = DownloadTeaching(teaching: teaching, onSuccess: onSuccess, onError: onError, onUpdate: onUpdate)
        downloadTeaching.task = session.downloadTask(with: urlReq)
        downloadTeaching.task!.resume()
        downloadTeaching.isDownloading = true
        
        dataTasks[url] = downloadTeaching
    }
}

extension MediaDownloadService: URLSessionDownloadDelegate {
    // This is for background call. TODO: TEST it
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler = appDelegate.backgroundSessionCompletionHandler else {
                    return
            }
            backgroundCompletionHandler()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let httpResponse = downloadTask.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print ("server error")
            return
        }
        
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        let downloadSource = self.dataTasks[sourceURL]
        
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let savedURL = documentsURL.appendingPathComponent(sourceURL.lastPathComponent)
            try FileManager.default.moveItem(at: location, to: savedURL)
            
            var teaching = downloadSource?.teaching
            teaching?.setLocalMedia(savedURL)
            
            DispatchQueue.main.async {
                downloadSource?.onSuccess(teaching!)
            }
            
            self.dataTasks[sourceURL] = nil
            print("Finished download to \(savedURL)")
        } catch {
            downloadSource?.onError("Error saving file. Please check sufficient space")
            print ("file error: \(error)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        let downloadSource = self.dataTasks[sourceURL]

        let prctg = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            downloadSource?.onUpdate(prctg)
        }
    }
}

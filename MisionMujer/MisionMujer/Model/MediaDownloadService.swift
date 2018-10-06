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
    
    var progress: Float = 0
    
    init(teaching: Teaching) {
        self.teaching = teaching
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
    
    func download(teaching: Teaching) {
        print("Starting download")
        guard let url = URL(string: teaching.media) else { return }
        let urlReq = URLRequest(url: url)
        
        let downloadTeaching = DownloadTeaching(teaching: teaching)
        downloadTeaching.task = session.downloadTask(with: urlReq)
        downloadTeaching.task!.resume()
        downloadTeaching.isDownloading = true
        
        dataTasks[url] = downloadTeaching
    }
}

extension MediaDownloadService: URLSessionDownloadDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("Aca 3")

        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler = appDelegate.backgroundSessionCompletionHandler else {
                    print("Aca 99sd")
                    return
            }
            backgroundCompletionHandler()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Aca final")
        guard let httpResponse = downloadTask.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print ("server error")
            return
        }
        
        do {
            print("Finish download")

            let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            let savedURL = documentsURL.appendingPathComponent(location.lastPathComponent)
            try FileManager.default.moveItem(at: location, to: savedURL)
        } catch {
            print ("file error: \(error)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        let prctg = (totalBytesWritten / totalBytesExpectedToWrite) * 100
        print("Conitnue download")

        print("Writenn \(prctg)")
    }
}

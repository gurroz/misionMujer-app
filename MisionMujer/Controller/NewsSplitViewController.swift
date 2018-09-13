//
//  NewsSplitViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 13/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import UIKit

class NewsplitViewController: UISplitViewController,
UISplitViewControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}

//
//  OverviewShowViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class OverviewShowViewController: UIViewController {
    
    @IBOutlet weak var showOverview: UITextView!
    
    var selectedShow : Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showOverview.text = selectedShow!.overview
    }
}

//
//  OverviewShowViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class OverviewShowViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var showOverview: UITextView!
    @IBOutlet weak var overviewTitle: UILabel!
    
    var selectedShow : Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadShow()
    }
    
    func intrinsicContentSize() -> CGSize {
        
        var titleH = overviewTitle.intrinsicContentSize().height + overviewTitle.bounds.height
        
        let h = showOverview.intrinsicContentSize().height + titleH

        return CGSize(width: showOverview.intrinsicContentSize().width, height: h)
    }
    
    func LoadShow() -> Void {
        
        if let show = self.selectedShow {
            
            if let overview = show.overview {
                showOverview.text = overview
            }
            else {
                showOverview.text = "Loading..."
            }
        }
    }
}

//
//  ShowGenresViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels
import TagListView

class ShowGenresViewController: UIViewController {
    
    @IBOutlet weak var genresList: TagListView!
    
    var selectedShow : Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for genre in selectedShow!.genres! {
            genresList.addTag(genre)
        }
    }
}

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

class ShowGenresViewController: UIViewController, ShowInternalViewController {
    
    @IBOutlet weak var genresList: TagListView!
    
    var selectedShow : Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genresList.textFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        
        LoadGenres()
    }
    
    func intrinsicContentSize() -> CGSize {
        
        return CGSize(width: genresList.intrinsicContentSize().width, height: genresList.intrinsicContentSize().height + 24.0)
    }
    
    func LoadGenres() {
        
        genresList.removeAllTags()
        if let show = self.selectedShow {
            for genre in show.genres! {
                genresList.addTag(genre)
            }
        }
    }
}

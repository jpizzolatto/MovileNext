//
//  EpisodesListViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit

class EpisodesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.EpisodeCell.identifier!

        let cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = "In section \(indexPath.section)"
        cell.detailTextLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
}

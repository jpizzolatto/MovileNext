//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import UIKit
import TraktModels

class ShowsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var showsView: UICollectionView!
    
    private let httpClient = TraktHTTPClient()
    private var popularShows : [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadShows()
    }
    
    private func loadShows() {
        
        httpClient.getPopularShows({[weak self] result in
            
            if let shows = result.value {
                self?.popularShows = shows
                self?.showsView.reloadData()
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.select_show {
            if let cell = sender as? UICollectionViewCell,
                   indexPath = showsView.indexPathForCell(cell) {
                   
                    let vc = segue.destinationViewController as! DetailShowViewController
                    
                    if let id = popularShows[indexPath.row].identifiers.slug {
                        
                        vc.showID = id
                        vc.selectedShowTitle = popularShows[indexPath.row].title
                    }
                    
                    self.showsView.deselectItemAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularShows.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = Reusable.ShowCell.identifier!
        
        let item = showsView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowItemCollectionViewCell
        
        let show = self.popularShows[indexPath.row]
        item.loadShow(show)
        
        return item
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        var flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        var itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        var maxPerRow = floor(collectionView.bounds.width / itemSize)
        
        var usedSpace = itemSize * maxPerRow
        var additionalSpace = flowLayout.minimumInteritemSpacing * maxPerRow
        
        var sideSpace = floor(((collectionView.bounds.width - usedSpace) + additionalSpace) / (maxPerRow + 1))
        
        return UIEdgeInsetsMake(flowLayout.sectionInset.top, sideSpace, flowLayout.sectionInset.bottom, sideSpace)
    }
    
}

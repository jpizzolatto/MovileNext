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
    var refreshControl:UIRefreshControl!
    
    var allShows : [Show] = []
    var visibleShows : [Show] = []
    var currentPage = 1
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private let httpClient = TraktHTTPClient()
    private let favManager = FavoritesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apperance = UIToolbar.appearance()
        apperance.barTintColor = UIColor.mup_orangeColor()
        
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let apperanceBtn = UISegmentedControl.appearance()
        apperanceBtn.tintColor = UIColor.whiteColor()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.showsView.addSubview(refreshControl)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "favoritesChanged", name: favManager.favoritesChangedNotificationName, object: nil)
        
        loadShows()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: favManager.favoritesChangedNotificationName, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.showBottomHairline()
    }
    
    func favoritesChanged() -> Void {
        indexChanged(segmentedControl)
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.visibleShows = self.allShows
            self.showsView.reloadData()
            
        case 1:
            let favorites = self.allShows.filter { $0 != nil }.filter { self.favManager.favoriteIdentifiers.contains($0.identifiers.slug!) }
            self.visibleShows = favorites
            self.showsView.reloadData()
            
        default:
            break; 
        } 
    }
    
    func refresh(sender:AnyObject) {
        
        currentPage = 1
        self.allShows.removeAll(keepCapacity: true)
        self.visibleShows.removeAll(keepCapacity: true)
        self.showsView.reloadData()
        
        loadShows()
    }
    
    private func loadShows() {
        
        httpClient.getPopularShows(currentPage, completion: {[weak self] result in
            
            if let shows = result.value {
                self?.allShows += shows
                self?.indexChanged(self!.segmentedControl)
                
                self?.showsView.reloadSections(NSIndexSet(index: 0))
                self?.refreshControl.endRefreshing()

                self?.loadingMore = false
            }
        })
    }
    
    var loadingMore = false
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var scrollViewHeight = scrollView.bounds.size.height
        var scrollContentSizeHeight = scrollView.contentSize.height
        var bottomInset = scrollView.contentInset.bottom
        var scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        
        if scrollView.contentOffset.y > scrollViewBottomOffset && !loadingMore {
            
            loadingMore = true
            currentPage++
            loadShows()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.select_show {
            if let cell = sender as? UICollectionViewCell,
                   indexPath = showsView.indexPathForCell(cell) {
                   
                    let vc = segue.destinationViewController as! DetailShowViewController
                    
                    if let id = visibleShows[indexPath.row].identifiers.slug {
                        
                        vc.showID = id
                        vc.selectedShowTitle = visibleShows[indexPath.row].title
                        vc.showIndex = indexPath.row
                    }
                    
                    self.showsView.deselectItemAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.visibleShows.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = Reusable.ShowCell.identifier!
        
        let item = showsView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowItemCollectionViewCell
        
        let show = self.visibleShows[indexPath.row]
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

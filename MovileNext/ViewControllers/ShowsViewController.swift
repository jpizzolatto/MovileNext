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
    var lastPage : Int?
    var loadedShows = [Int : [Show]]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emptyView: UIView!
    
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    private let httpClient = TraktHTTPClient()
    private let favManager = FavoritesManager()
    private let group = dispatch_group_create()
    
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
        
        let savedLastPage: AnyObject? = userDefaults.objectForKey("lastPage")
        if savedLastPage == nil {
            userDefaults.setInteger(currentPage, forKey: "lastPage")
            lastPage = currentPage
        }
        else {
            lastPage = savedLastPage as? Int
        }
        
        for index in 1 ... lastPage! {
            loadShows(index)
            currentPage = index
        }
        
        groupNotifyToConcatenateShowsList()
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
    
    func groupNotifyToConcatenateShowsList() -> Void {
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { [weak self] in
            
            if let s = self, last = s.lastPage {
                
                for index in 1 ... last {
                    s.allShows += s.loadedShows[index]!
                }
                // Clean the dictionary
                s.loadedShows.removeAll(keepCapacity: true)
                
                // Update the view
                s.indexChanged(self!.segmentedControl)
                s.refreshControl.endRefreshing()
                s.loadingMore = false
            }
        }
    }
    
    func refresh(sender:AnyObject) {
        
        self.allShows.removeAll(keepCapacity: true)
        
        loadingMore = true
        for index in 1 ... lastPage! {
            loadShows(index)
            currentPage = index
        }
        
        groupNotifyToConcatenateShowsList()
    }
    
    private func loadShows(page: Int) {
        
        dispatch_group_enter(group)
        
        httpClient.getPopularShows(page, completion: {[weak self] result in
            
            if let shows = result.value {
                self?.loadedShows[page] = shows
                
                if let s = self {
                    dispatch_group_leave(s.group)
                }
            }
        })
    }
    
    var loadingMore = false
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // It's favorite tab, ignore load more pages
        if segmentedControl.selectedSegmentIndex == 1 {
            return
        }
        
        var scrollViewHeight = scrollView.bounds.size.height
        var scrollContentSizeHeight = scrollView.contentSize.height
        var bottomInset = scrollView.contentInset.bottom
        var scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        
        if scrollView.contentOffset.y > scrollViewBottomOffset && !loadingMore {
            
            loadingMore = true
            currentPage++
            
            // Save the last page into the database
            userDefaults.setInteger(currentPage, forKey: "lastPage")
            
            loadShows(currentPage)
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
        
        self.emptyView.hidden = self.visibleShows.count > 0
            
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

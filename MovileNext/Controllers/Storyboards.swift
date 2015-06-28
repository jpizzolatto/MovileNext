//
// Autogenerated by Natalie - Storyboard Generator Script.
// http://blog.krzyzanowskim.com
//

import UIKit

//MARK: - Storyboards
struct Storyboards {

    struct Main {

        static let identifier = "Main"

        static var storyboard:UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> CustomNavigationController! {
            return self.storyboard.instantiateInitialViewController() as! CustomNavigationController
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, Printable {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, Printable {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             

    var description: String { return self.rawValue } 
}

//MARK: - SegueProtocol
public protocol IdentifiableProtocol: Equatable {
    var identifier: String? { get }
}

public protocol SegueProtocol: IdentifiableProtocol {
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - ReusableProtocol
public protocol ReusableProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? {get}
}

public func ==<T: ReusableProtocol, U: ReusableProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

extension UITableViewCell: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

//MARK: - UIViewController extension
extension UIViewController {
    func performSegue<T: SegueProtocol>(segue: T, sender: AnyObject?) {
       performSegueWithIdentifier(segue.identifier, sender: sender)
    }
}

//MARK: - UICollectionViewController

extension UICollectionViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableCellWithReuseIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableProtocol>(elementKind: String, withReusable reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableViewController

extension UITableViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.tableView!.dequeueReusableCellWithIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusableCell<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.tableView?.registerClass(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableProtocol>(reusable: T) -> AnyObject? {
        if let identifier = reusable.identifier {
            return self.tableView?.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
             self.tableView?.registerClass(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

//MARK: - EpisodeViewController

//MARK: - EpisodesListViewController
extension UIStoryboardSegue {
    func selection() -> EpisodesListViewController.Segue? {
        if let identifier = self.identifier {
            return EpisodesListViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension EpisodesListViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case show_single_episode = "show_single_episode"

        var kind: SegueKind? {
            switch (self) {
            case show_single_episode:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case show_single_episode:
                return EpisodeViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension EpisodesListViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case EpisodeCell = "EpisodeCell"

        var kind: ReusableKind? {
            switch (self) {
            case EpisodeCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case EpisodeCell:
                return EpisodeTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - CustomNavigationController

//MARK: - ShowsViewController
extension UIStoryboardSegue {
    func selection() -> ShowsViewController.Segue? {
        if let identifier = self.identifier {
            return ShowsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowsViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case select_show = "select_show"

        var kind: SegueKind? {
            switch (self) {
            case select_show:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case select_show:
                return DetailShowViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension ShowsViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case ShowCell = "ShowCell"

        var kind: ReusableKind? {
            switch (self) {
            case ShowCell:
                return ReusableKind(rawValue: "collectionViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case ShowCell:
                return ShowItemCollectionViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - DetailShowViewController
extension UIStoryboardSegue {
    func selection() -> DetailShowViewController.Segue? {
        if let identifier = self.identifier {
            return DetailShowViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension DetailShowViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case overview_container = "overview_container"
        case seasons_container = "seasons_container"
        case genres_container = "genres_container"
        case details_container = "details_container"

        var kind: SegueKind? {
            switch (self) {
            case overview_container:
                return SegueKind(rawValue: "embed")
            case seasons_container:
                return SegueKind(rawValue: "embed")
            case genres_container:
                return SegueKind(rawValue: "embed")
            case details_container:
                return SegueKind(rawValue: "embed")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case overview_container:
                return OverviewShowViewController.self
            case seasons_container:
                return SeasonsViewController.self
            case genres_container:
                return ShowGenresViewController.self
            case details_container:
                return ShowDetailsViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

//MARK: - SeasonsViewController
extension UIStoryboardSegue {
    func selection() -> SeasonsViewController.Segue? {
        if let identifier = self.identifier {
            return SeasonsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension SeasonsViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case show_episode = "show_episode"

        var kind: SegueKind? {
            switch (self) {
            case show_episode:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case show_episode:
                return EpisodesListViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension SeasonsViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case SeasonCell = "SeasonCell"

        var kind: ReusableKind? {
            switch (self) {
            case SeasonCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case SeasonCell:
                return SeasonTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowGenresViewController

//MARK: - ShowDetailsViewController

//MARK: - OverviewShowViewController

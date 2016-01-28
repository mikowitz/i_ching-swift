//
//  MasterViewController.swift
//  IChing
//
//  Created by Michael Berkowitz on 1/26/16.
//  Copyright © 2016 Michael Berkowitz. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var hexagrams = [Hexagram]()
    var castingMethod : String?


    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        loadHexagrams()
    }
    
    func loadHexagrams() {
        Hexagram.fetchHexagrams() { hexagrams in
            self.hexagrams = hexagrams
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showDetail":
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let hexagram = hexagrams[indexPath.row] as Hexagram
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.kingWenNumber = hexagram.kingWenNumber
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
            }
        case "showCastScreen":
            let controller = (segue.destinationViewController as! IChingNavigationViewController).topViewController as! CastHexagramViewController
            if let castingMethod = self.castingMethod {
                controller.castingMethod = castingMethod
            } else {
                controller.castingMethod = "Yarrow"
            }
        default:
            print("unknown segue: \(segue.identifier!)")
        }
    }

    // MARK: - Casting hexagram menu
    
    func castHexagramMenu() -> UIAlertController {
        let alertController = UIAlertController(title: "Cast Hexagram", message: "Choose casting method", preferredStyle: .ActionSheet)
        let methods = ["Yarrow", "Coins", "Random"]
        for method in methods {
            let action = UIAlertAction(title: method, style: .Default) { Void in
                self.castHexagram(method)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    func castHexagram(castingMethod: String) {
        self.castingMethod = castingMethod
        performSegueWithIdentifier("showCastScreen", sender: self)
    }

}


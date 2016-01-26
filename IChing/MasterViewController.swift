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


    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        loadHexagrams()
        
    }
    
    func loadHexagrams() {
        Alamofire.request(.GET, "https://verdant-meadow-71296.herokuapp.com/api/v1/hexagrams")
            .responseJSON { response in
                
                if let JSONString = response.result.value {
                    self.hexagrams = Mapper<Hexagram>().mapArray(JSONString) as [Hexagram]!
                    self.tableView.reloadData()
                }
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
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let hexagram = hexagrams[indexPath.row] as Hexagram
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.kingWenNumber = hexagram.kingWenNumber
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return hexagrams.count
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let castHexagramAlertController = castHexagramMenu()
            presentViewController(castHexagramAlertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 20.0
        default: return 0.0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HexagramCell", forIndexPath: indexPath)

            let hexagram = hexagrams[indexPath.row] as Hexagram
            cell.textLabel!.text = hexagram.chineseName
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CastHexagramCell", forIndexPath: indexPath)
            cell.textLabel!.text = "Cast Hexagram"
            return cell
        }
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

    
    // MARK: - Casting hexagram menu
    
    func castHexagramMenu() -> UIAlertController {
        let alertController = UIAlertController(title: "Cast Hexagram", message: "Choose casting method", preferredStyle: .ActionSheet)
        let yarrowAction = UIAlertAction(title: "Yarrow", style: .Default) { Void in
            print("cast with yarrow")
            self.castHexagram("Yarrow")
        }
        let coinsAction = UIAlertAction(title: "Coins", style: .Default) { Void in
            print("cast with coins")
            self.castHexagram("Coins")
        }
        let randomAction = UIAlertAction(title: "Random", style: .Default) { Void in
            print("cast with random")
            self.castHexagram("Random")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(yarrowAction)
        alertController.addAction(coinsAction)
        alertController.addAction(randomAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    func castHexagram(castingMethod: String) {
        print(castingMethod)
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("IChingNavigationViewController") as! IChingNavigationViewController
        let castingController = navigationController.viewControllers[0] as! CastHexagramViewController
        castingController.castingMethod = castingMethod
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

}


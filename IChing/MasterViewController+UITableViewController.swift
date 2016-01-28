//
//  MasterViewController+UITableViewController.swift
//  IChing
//
//  Created by Michael Berkowitz on 1/28/16.
//  Copyright © 2016 Michael Berkowitz. All rights reserved.
//

import UIKit

extension MasterViewController {

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
            cell.detailTextLabel!.text = hexagram.englishName
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
}

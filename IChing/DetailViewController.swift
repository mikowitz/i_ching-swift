//
//  DetailViewController.swift
//  IChing
//
//  Created by Michael Berkowitz on 1/26/16.
//  Copyright © 2016 Michael Berkowitz. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class DetailViewController: UIViewController {

    @IBOutlet weak var englishName: UILabel!

    var hexagram : Hexagram?

    var kingWenNumber : Int? {
        didSet {
            Hexagram.fetchHexagram(kingWenNumber!) { hexagram in
                self.hexagram = hexagram
                self.configureView()
            }
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let hexagram = self.hexagram {
            self.title = hexagram.chineseName
            if let englishNameLabel = self.englishName {
                englishNameLabel.text = hexagram.englishName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


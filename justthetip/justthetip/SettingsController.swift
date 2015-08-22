//
//  SettingsController.swift
//  justthetip
//
//  Created by Patrick Stein on 8/21/15.
//  Copyright (c) 2015 patrick. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
  @IBOutlet weak var chooser: UISegmentedControl!
  
  var settings: NSUserDefaults = NSUserDefaults.standardUserDefaults()

  override func viewDidLoad() {
    super.viewDidLoad()
    chooser.selectedSegmentIndex = settings.integerForKey("default_index")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  @IBAction func percentageChanged(sender: AnyObject) {
    settings.setInteger(chooser.selectedSegmentIndex, forKey: "default_index")
    settings.synchronize()
  }
}

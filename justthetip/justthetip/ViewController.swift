//
//  ViewController.swift
//  justthetip
//
//  Created by Patrick Stein on 8/21/15.
//  Copyright (c) 2015 patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var baseField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var tipChooser: UISegmentedControl!

  var percentage: Double = 0.0
  var base: Double = 0.0
  let settings = NSUserDefaults.standardUserDefaults()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    tipChooser.selectedSegmentIndex = settings.integerForKey("default_index")
    self.percentageChanged(tipChooser)
  
    let lastUpdated = settings.doubleForKey("last_price_time")
    let now = NSDate().timeIntervalSince1970
    if (lastUpdated != 0 && (now - lastUpdated) < 600) {
      base = settings.doubleForKey("last_price")
      if (base != 0) {
        baseField.text = NSString(format: "%.2f", settings.doubleForKey("last_price")) as String
        update()
      }
    }
    
    baseField.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func format(n: Double) -> String {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    return formatter.stringFromNumber(n)!
  }
  
  func update() {
    let tip = percentage * base
    
    tipLabel.text = format(tip)
    totalLabel.text = format(tip + base)
  }
  
  @IBAction func priceChanged(sender: AnyObject) {
    let field = sender as! UITextField    
    base = (field.text as NSString).doubleValue
    settings.setDouble(base, forKey: "last_price")
    settings.setDouble(NSDate().timeIntervalSince1970, forKey: "last_price_time")
    settings.synchronize()
    update()
  }
  
  @IBAction func percentageChanged(sender: AnyObject) {
    let chooser = sender as! UISegmentedControl
    var text = chooser.titleForSegmentAtIndex(chooser.selectedSegmentIndex)!
    text = text.substringWithRange(text.startIndex ..< advance(text.endIndex, -1))
    
    var val = text.toInt()
    if (val != nil) {
      percentage = Double(text.toInt()!) / 100.0
      update()
    }
  }
}


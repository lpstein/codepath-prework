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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    baseField.text = NSString(format: "%.2f", base) as String
    
    let settings = NSUserDefaults.standardUserDefaults()
    tipChooser.selectedSegmentIndex = settings.integerForKey("default_index")
    self.percentageChanged(tipChooser)
  }

  override func viewDidAppear(animated: Bool) {
    baseField.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func update() {
    let tip = percentage * base
    
    tipLabel.text = NSString(format: "$%.2f", tip) as String
    totalLabel.text = NSString(format: "$%.2f", tip + base) as String
  }
  
  @IBAction func priceChanged(sender: AnyObject) {
    let field = sender as! UITextField    
    base = (field.text as NSString).doubleValue
    
    update()
  }
  
  @IBAction func percentageChanged(sender: AnyObject) {
    let chooser = sender as! UISegmentedControl
    var text = chooser.titleForSegmentAtIndex(chooser.selectedSegmentIndex)!
    text = text.substringWithRange(text.startIndex ..< advance(text.endIndex, -1))
    
    percentage = Double(text.toInt()!) / 100.0
    
    update()
  }
}


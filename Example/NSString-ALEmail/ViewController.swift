//
//  ViewController.swift
//  NSString-ALEmail
//
//  Created by aligermiyanoglu on 08/11/2016.
//  Copyright (c) 2016 aligermiyanoglu. All rights reserved.
//

import UIKit
import NSString_ALEmail

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let email = "ali@aaa"
        NSLog("isvalid: \(email.isValidEmail())")
        NSLog("isDisposable: \(email.isDisposableEmail())")
        NSLog("ended")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}


//
//  ViewController.swift
//  UCS
//
//  Created by Vallard Benincosa on 8/29/16.
//  Copyright © 2016 Cisco Systems. All rights reserved.
//
import Alamofire
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ucsSystemTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didSignPressSignIn(sender: AnyObject) {
        if valuesReady() {
            attemptLogin("10.93.234.238", user: "admin", password: "oicu812!")
        }
    }
    
    func valuesReady() -> Bool {
        return true
    }
    
    func attemptLogin(ucsUrl: String, user: String, password: String) {
        let ucs = UCS()
        ucs.connect(ucsUrl, user: user, password: password)
    }
    
}


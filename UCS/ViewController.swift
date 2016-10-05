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
    let ucs = UCS()
    
    var ucsIP = ""
    var user = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didSignPressSignIn(_ sender: AnyObject) {
        if valuesReady() {
            attemptLogin(ucsIP, user: user, password: password)
        }
    }
    
    func valuesReady() -> Bool {
        ucsIP = ucsSystemTextField.text!
        user = userNameTextField.text!
        password = passwordTextField.text!
        
        if (ucsIP == "") ||
            (user == "") ||
            (password == "")  {
            return false
        }
        return true
    }
    
    func attemptLogin(_ ucsUrl: String, user: String, password: String) {
        
       let b = ucs.connect(ucsUrl, user: user, password: password)
        print(b)
    }
    
}


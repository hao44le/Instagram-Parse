//
//  ViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    
    @IBAction func loginClicked(sender: AnyObject) {
        if passwordTextfield.text != nil && usernameTextfield.text != nil {
            
            Tool.showProgressHUD("Loading")
            PFUser.logInWithUsernameInBackground(self.usernameTextfield.text!, password: self.passwordTextfield.text!, block: { (user:PFUser?, error:NSError?) -> Void in
                Tool.dismissHUD()
                if let error = error {
                    print(error.localizedDescription)
                    Tool.showErrorHUD("error occured, try again.")
                } else {
                    print("Login succesfully!")
                    self.performSegueWithIdentifier("toMain", sender: self)
                }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextfield.secureTextEntry = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("toMain", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


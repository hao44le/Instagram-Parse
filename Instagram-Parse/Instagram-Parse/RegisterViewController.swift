//
//  RegisterViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBAction func registerClicked(sender: AnyObject) {
        if passwordTextfield.text != nil && emailTextfield.text != nil && usernameTextfield.text != nil {
            Tool.showProgressHUD("Loading")
            let newUser = PFUser()
            newUser.username = usernameTextfield.text
            newUser.email = emailTextfield.text
            newUser.password = passwordTextfield.text
            newUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                Tool.dismissHUD()
                
                if let error = error {
                    Tool.showErrorHUD("error occured. Try again")
                    print(error.localizedDescription)
                } else {
                    print("User registered succesfully!")
                    Tool.showProgressHUD("Loading")
                    PFUser.logInWithUsernameInBackground(self.usernameTextfield.text!, password: self.passwordTextfield.text!, block: { (user:PFUser?, error:NSError?) -> Void in
                        Tool.dismissHUD()

                        if let error = error {
                            Tool.showErrorHUD("error occured. Try again")
                            print(error.localizedDescription)
                        } else {
                            print("Login succesfully!")
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    })
                }
            }

        }
        
    }
    @IBAction func cancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextfield.secureTextEntry = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

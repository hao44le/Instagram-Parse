//
//  LogoutViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {

    @IBAction func logoutButtonClicked(sender: AnyObject) {
        Tool.showProgressHUD("Logging out")
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            Tool.dismissHUD()
            if error != nil {
                Tool.showErrorHUD("Failed to logout try again ?")
            } else {
                self.tabBarController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 45/255, green: 15/255, blue: 62/255, alpha: 1)
        let jeremyGif = UIImage.gifWithName("no")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: (UIScreen.mainScreen().bounds.width - 100)/2, y: UIScreen.mainScreen().bounds.height - 258 , width: 100, height: 100)
        
        view.addSubview(imageView)
        
        let hambergerGif = UIImage.gifWithName("hambeger")
        let hamberimageView = UIImageView(image: hambergerGif)
        hamberimageView.frame = CGRect(x: 20, y: 64, width: 150, height: 150)
        
        view.addSubview(hamberimageView)
        
        let imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("twoCat", withExtension: "gif")!)
        let advTimeGif = UIImage.gifWithData(imageData!)
        let imageView2 = UIImageView(image: advTimeGif)
        imageView2.frame = CGRect(x: UIScreen.mainScreen().bounds.width - 170, y: 64, width: 150, height: 150)
        
        view.addSubview(imageView2)
        
        
        let nameLabel = UILabel(frame: CGRectMake((UIScreen.mainScreen().bounds.width - 150)/2,UIScreen.mainScreen().bounds.height / 2
            - 50 ,150,50))
        nameLabel.text = PFUser.currentUser()!.username
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont.systemFontOfSize(24)
        nameLabel.textColor = UIColor.whiteColor()
        view.addSubview(nameLabel)
        
        let donGoLabel = UILabel(frame: CGRectMake((UIScreen.mainScreen().bounds.width - 300)/2,UIScreen.mainScreen().bounds.height / 2
            ,300,50))
        donGoLabel.text = "Don't Go.We Miss you."
        donGoLabel.textAlignment = NSTextAlignment.Center
        donGoLabel.font = UIFont.systemFontOfSize(20)
        donGoLabel.textColor = UIColor.whiteColor()
        view.addSubview(donGoLabel)
        
        self.logoutButton.layer.cornerRadius = self.logoutButton.frame.height / 2
        
        
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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

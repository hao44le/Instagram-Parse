//
//  PostViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tabButton: UIButton!
    @IBAction func submitClicked(sender: AnyObject) {
        if self.resizedImage == nil {
            Tool.showErrorHUD("Please select an image")
        } else if self.textField.text == "" {
            Tool.showErrorHUD("Please write something")
        } else {
            Tool.showProgressHUD("Loading")
            UserMedia.postUserImage(self.resizedImage, withCaption: self.textField.text, withCompletion: { (success:Bool, error:NSError?) -> Void in
                Tool.dismissHUD()
                if success {
                    Tool.showSuccessHUD("Successfully upload the image")
                }
                if error != nil {
                    Tool.showErrorHUD("Please try to upload the image again")
                }
            })
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBAction func tapClicked(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    var resizedImage:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            picker.dismissViewControllerAnimated(true, completion: nil)
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            resizedImage = Tool.resize(originalImage, newSize: CGSizeMake(UIScreen.mainScreen().bounds.width, 80))
            self.tabButton.setBackgroundImage(originalImage, forState: UIControlState.Normal)
            
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

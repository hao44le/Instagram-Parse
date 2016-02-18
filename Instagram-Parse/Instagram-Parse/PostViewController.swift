//
//  PostViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate  {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var imageUploadProgressView: UIProgressView!
    @IBOutlet weak var submitButton: UIButton!
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
        
        self.view.backgroundColor = UIColor(red: 45/255, green: 15/255, blue: 62/255, alpha: 1)
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2

        // Do any additional setup after loading the view.
    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            picker.dismissViewControllerAnimated(true, completion: nil)
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            resizedImage = Tool.resize(originalImage, newSize: CGSizeMake(UIScreen.mainScreen().bounds.width, 80))
            self.tabButton.setBackgroundImage(originalImage, forState: UIControlState.Normal)
            self.tabButton.setTitle("", forState: UIControlState.Normal)
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?)
    {
        Tool.showErrorHUD(error!.localizedDescription)
        self.submitButton.enabled = true
        
    }
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
    {
        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        imageUploadProgressView.progress = uploadProgress
        let progressPercent = Int(uploadProgress*100)
        progressLabel.text = "\(progressPercent)%"
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void)
    {
        self.submitButton.enabled = true
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

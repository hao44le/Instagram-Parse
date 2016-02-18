//
//  ImageTableViewCell.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var userImage:UIImageView!
    var likesLabel:UILabel!
    var commentsCountLabel:UILabel!
    var detailTextView:UITextView!
    var userNameLabel : UILabel!
    var timeAgoLabel : UILabel!
    var likesButton :UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        userNameLabel = UILabel(frame: CGRectMake(10,5,100,25))
        self.addSubview(userNameLabel)
        
        timeAgoLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 210,5,200,25))
        timeAgoLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(timeAgoLabel)
        
        userImage = UIImageView(frame: CGRectMake(0,30,UIScreen.mainScreen().bounds.width,200))
        self.addSubview(userImage)
        
        likesButton = UIButton(frame: CGRectMake(5,240,20,20))
        likesButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
        self.addSubview(likesButton)
        
        likesLabel = UILabel(frame: CGRectMake(30,235,150,30))
        self.addSubview(likesLabel)
        
        commentsCountLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 160,235,150,30))
        commentsCountLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(commentsCountLabel)
        
        detailTextView = UITextView(frame: CGRectMake(10,270,UIScreen.mainScreen().bounds.width - 20,30))
        detailTextView.selectable = false
        self.addSubview(detailTextView)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

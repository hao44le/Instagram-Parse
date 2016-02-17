//
//  ImageTableViewCell.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import Parse
import SDWebImage

class ImageTableViewCell: UITableViewCell {

    var userImage:UIImageView!
    var likesLabel:UILabel!
    var commentsCountLabel:UILabel!
    var detailTextView:UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print(self.frame.height)
        userImage = UIImageView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,200))
        self.addSubview(userImage)
        
        
        likesLabel = UILabel(frame: CGRectMake(10,205,150,30))
        self.addSubview(likesLabel)
        
        commentsCountLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 160,205,150,30))
        commentsCountLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(commentsCountLabel)
        
        detailTextView = UITextView(frame: CGRectMake(10,240,UIScreen.mainScreen().bounds.width - 20,50))
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

//
//  CustomTableViewCell.swift
//  ASD Scheduler
//
//  Created by Admin on 11/30/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{
    // Class Variables
    var nameText: String? =  "TestName"
    var tagText: String? = "TestTag"
    
    let padding: CGFloat = 5
    var background: UIView!
    var nameLabel: UILabel!
    var tagLabel: UILabel!
    var imageViewLabel: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .none
        
        // Cell Background
        background = UIView(frame: CGRect.zero)
        background.alpha = 0.6
        contentView.addSubview(background)
        
        // Cell Image
        imageViewLabel = UIImageView(frame: CGRect.zero)
        contentView.addSubview(imageViewLabel)
        
        // Cell Name
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.black
        nameLabel.text = nameText
        nameLabel.backgroundColor = UIColor.white
        contentView.addSubview(nameLabel)
        
        // Cell Tag
        tagLabel = UILabel(frame: CGRect.zero)
        tagLabel.textAlignment = .left
        tagLabel.textColor = UIColor.black
        tagLabel.text = tagText
        tagLabel.backgroundColor = UIColor.white
        contentView.addSubview(tagLabel)    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    // Set the sizes of the subviews
    override func layoutSubviews()
    {
        super.layoutSubviews()
        background.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height * 2)
        imageViewLabel.frame = CGRect.init(x: 0, y: 0, width: 150, height:150)
        nameLabel.frame = CGRect.init(x: imageViewLabel.frame.width + padding, y: (frame.height - 25)/2, width: 150, height: 25)
        tagLabel.frame = CGRect.init(x: frame.width - 100, y: padding, width: 100, height: frame.height - 2 * padding)
    }
}

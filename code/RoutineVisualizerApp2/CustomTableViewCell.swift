/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  CustomTableViewCell.swift
 * File Description:  Creates a custom table view cell for RoutineManager
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import UIKit

class CustomTableViewCell: UITableViewCell
{
    // Class Variables
    var nameText: String? =  "TestName"
    var tagText: String? = "TestTag"
    var imageViewLabel: UIImageView!
    
    let padding: CGFloat = 5
    var background: UIView!
    var nameLabel: UILabel!
    var tagLabel: UILabel!
    
    //---------------------------------------------------
    // Function: init()
    //---------------------------------------------------
    // Parameters:
    //      input UITableViewCellStyle, the cell style
    //      input String, the cell identifier
    //
    // Pre-Condition:   None
    // Post-Condition:  Extends UITableViewCell
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: init?()
    //---------------------------------------------------
    // Parameters:
    //      input NSCoder, a decoder
    //
    // Pre-Condition:   None
    // Post-Condition:  Essential method for custom cell
    //---------------------------------------------------
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------------------------------------
    // Function: prepareForReuse()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   None
    // Post-Condition:  Cell can be reused by methods
    //---------------------------------------------------
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    //---------------------------------------------------
    // Function: layoutSubviews()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   None
    // Post-Condition:  Setup subviews frame's for custom cell
    //---------------------------------------------------
    override func layoutSubviews()
    {
        super.layoutSubviews()
        background.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height * 2)
        imageViewLabel.frame = CGRect.init(x: 0, y: 0, width: 150, height:150)
        nameLabel.frame = CGRect.init(x: imageViewLabel.frame.width + padding, y: (frame.height - 25)/2, width: 150, height: 25)
        tagLabel.frame = CGRect.init(x: frame.width - 100, y: padding, width: 100, height: frame.height - 2 * padding)
    }
}

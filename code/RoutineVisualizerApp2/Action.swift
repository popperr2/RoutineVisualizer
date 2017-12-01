/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  Action.swift
 * File Description:  This is an action item.
 * Last Modified On: November 29, 2017
 * ----------------------------------------------*/

import Foundation
import UIKit

class Action
{
    var name: String                    // Action Name
    var imageName: String               // Action Image
    var description: String        // Action Description
    
    // Intialize Action Object
    init(name: String, imageName: String, description: String)
    {
        self.name = name
        self.imageName = imageName
        self.description = description
    }
}

/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  Routine.swift
 * File Description:  This is a routine object.
 * Last Modified On: November 29, 2017
 * ----------------------------------------------*/

import UIKit
import Foundation

class Routine
{
    var name: String                        // Name of the Routine
    var imageName: String                   // Name of the Routine's Image
    var tag: String                         // The Tag of the Routine
    var actions = Array<Action>()           // Array of Actions

    // Intialize Routine Object
    init()
    {
        self.name = "nil"
        self.imageName = "nil"
        self.tag = "nil"
        self.actions = Array<Action>()
    }
    
    init(name: String, imageName: String, tag: String, actions: Array<Action>)
    {
        self.name = name
        self.imageName = imageName
        self.tag = tag
        self.actions = actions
    }
    
    // Add Actions to a Routine Objects Action's Array
    func addAction(insertAction: Action)
    {
        print ("Inserting action " + insertAction.name)
        self.actions.append(insertAction)
    }
}

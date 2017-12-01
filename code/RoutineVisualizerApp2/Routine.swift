/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  Routine.swift
 * File Description:  This is a routine object to be used by RoutineManager class.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import UIKit
import Foundation

class Routine
{
    // Class Variables
    var name: String                        // Name of the Routine
    var imageName: String                   // Name of the Routine's Image
    var tag: String                         // The Tag of the Routine
    var actions = Array<Action>()           // Array of Actions

    //---------------------------------------------------
    // Function: init()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   None
    // Post-Condition:  Creates a default Routine
    //---------------------------------------------------
    init()
    {
        self.name = "nil"
        self.imageName = "nil"
        self.tag = "nil"
        self.actions = Array<Action>()
    }
    
    //---------------------------------------------------
    // Function: init()
    //---------------------------------------------------
    // Parameters:
    //      input String, routine Name
    //      input String, routine Image Name
    //      input String, routine Tag
    //      input Array<Action>, actions Array
    //
    // Pre-Condition:   None
    // Post-Condition:  Creates a routine with the assigned
    //                  parameters
    //---------------------------------------------------
    init(name: String, imageName: String, tag: String, actions: Array<Action>)
    {
        self.name = name
        self.imageName = imageName
        self.tag = tag
        self.actions = actions
    }
    
    //---------------------------------------------------
    // Function: addAction()
    //---------------------------------------------------
    // Parameters:
    //      input Action, action to insert to array
    //
    // Pre-Condition:   None
    // Post-Condition:  Insert action to action array
    //                  shortcut
    //---------------------------------------------------
    public func addAction(insertAction: Action)
    {
        print ("Inserting action " + insertAction.name)
        self.actions.append(insertAction)
    }
}

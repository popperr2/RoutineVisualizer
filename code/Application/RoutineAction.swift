/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: RoutineAction.swift
 * File Description:  Actions contain steps.  Actions make up routines.  Actions can have one step or many steps.
 * Last Modified On: November 22, 2017
 */

import Foundation
import UIKit

class RoutineAction
{
    // Class Variables
    public var actionName: String!                      // Name of the Action
    public var actionMainStep: RoutineStep!             // Main Step gets displayed under "Routine View"
    public var actionSubSteps: [RoutineStep] = []       // Substeps that get displayed under "Action View"
    public var actionTime: Float?                       // How long does the action take to do
    public var isComplete: Bool!                      // Is the action completed
    
    // Class Methods
    
}

/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  Routine.swift
 * File Description:  This is a routine object to be used by Visualizer Class.  It extends from the Routine Class.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import Foundation
import UIKit

class VisualizerRoutine: Routine
{
    // Class Variables
    var isDone: Bool = false                // True if done
    var isInProgress: Bool = false          // True if in progress
    
    // Intialize VisualizerRoutine object
    override init()
    {
        super.init()
        self.isDone = false
        self.isInProgress = false
    }
}

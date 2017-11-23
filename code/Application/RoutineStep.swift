/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: RoutineStep.swift
 * File Description:  Steps exist inside of actions.  These are the micro-steps of an action like "teeth brushing."  A STEP of teeth brushing would be "open toothpaste" or "put toothpaste on brush."
 * Last Modified On: November 22, 2017
 *--------------------------------------------------------*/

import Foundation
import UIKit

class RoutineStep
{
    // Class Variables
    
    // The UI Image that defines this step, can be nil
    public var stepImage: UIImage?          // The image displayed for this step
    // The Description that defines this step, can be nil
    public var stepDescription: String?     // The description of the step
}

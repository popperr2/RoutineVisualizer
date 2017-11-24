/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: Routine.swift
 * File Description:  A routine is made up of actions.  They make up the daily schedule of routines.
 * Last Modified On: November 22, 2017
 */

import Foundation
import UIKit

class DailySchedule
{
    // Class Variables
    public var isEmpty: Bool!                   // Does the schedule contain routines?
    public var dailyRoutines: [Routine] = []    // Routines in the schedule
    public var dailyTime: Float?                // Time to do daily schedule
    public var isComplete: Bool!               // Status of Routine
}


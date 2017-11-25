/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: HomeViewController.swift
 * File Description:  This file manages the ViewController that manages the Home Schedule.
 * Last Modified On: November 5, 2017
 */

import UIKit
import SQLite

class DailyScheduleViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Insert a Routine Identifier into the table and then print the table
        // Saves, so have to delete app every time you run otherwise it adds a second one 
        let routine1 = DailyScheduleEntity.shared.insert(name: "Routine1IGuess")
        
        if let dailyScheduleQuery: AnySequence<Row> = DailyScheduleEntity.shared.queryAll()
        {
            for eachRoutine in dailyScheduleQuery {
                DailyScheduleEntity.shared.toString(routine: eachRoutine)
            }
        }
    }
}

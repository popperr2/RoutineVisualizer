/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  VisualizerViewController.swift
 * File Description:  This View Controller contains the view for the main screen that the routines can be viewed and checked off on.
 * Last Modified On: November 29, 2017
 * ----------------------------------------------*/

import UIKit
import SQLite

class VisualizerViewController: UIViewController
{
    // Class Variables
    private var tableView: UITableView!
    
    // When the view loads the first time
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // When the view is going to display
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
}


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

class VisualizerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // Class Variables
    private var tableView: UITableView!
    
    private var routinesArray: Array<Routine> = []      // Holds all routines in dailyschedule
    
    // When the view loads the first time
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Add TableView and Settings to VisualizerViewController
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(VisualizerTableViewCell.self, forCellReuseIdentifier: "visualizerCell")
        tableView.rowHeight = 150 // TO DO: Make this bigger to show you're in a different view
        self.view.addSubview(tableView)
    }
    
    // Runs every time the view is going to appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // When the view is about to appear, the model will
        // Update a blank routineArray based on SQL saved routines in VisualizerDatabase
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visualizerCell", for: indexPath) as! VisualizerTableViewCell
        
        // Assign from RoutinesArray to Cell
        cell.nameLabel.text = "Smoogle"
        cell.tagLabel.text = "Google"
        cell.imageViewLabel.image = UIImage(named: "moon")
        
        return cell
    }
}


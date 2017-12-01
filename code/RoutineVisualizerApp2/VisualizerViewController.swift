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
import Foundation

class VisualizerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // Class Variables
    private var tableView: UITableView!
    
    private var routinesArray: Array<VisualizerRoutine> = []      // Holds all visualizer routines in visualizer
    private var actionsArray: Array<Action> = []
    
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
        if let visualizerDatabaseQuery: AnySequence<Row> = VisualizerDatabase.shared.queryAll()
        {
            var temp: Int = 1
            for eachRoutine in visualizerDatabaseQuery
            {
                // Print SQL Contents
                VisualizerDatabase.shared.toString(routine: eachRoutine)
                
                // Add Attributes to RoutineHolder
                let routineHolder = VisualizerRoutine()
                routineHolder.name = VisualizerDatabase.shared.queryName(id: Int64(temp))!
                routineHolder.tag = VisualizerDatabase.shared.queryTag(id: Int64(temp))!
                routineHolder.imageName = VisualizerDatabase.shared.queryImageName(id: Int64(temp))!
                routineHolder.isDone = VisualizerDatabase.shared.queryIsDone(id: Int64(temp))!
                routineHolder.isInProgress = VisualizerDatabase.shared.queryIsInProgress(id: Int64(temp))!
                
                // Temporary Actions
                let exampleAction = Action(name: "ExampleAction", imageName: "sun", description: "exampleActionDescription")
                actionsArray.append(exampleAction)
                routineHolder.actions = actionsArray
                
                // Add RoutineHolder to routinesArray
                routinesArray.append(routineHolder)
            }
        }
        self.tableView.reloadData()
    }
    
    // Runs every time the user clicks off of the view
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // When the view is about to disappear, the model will
        // blanken SQL table, upload routineArray to SQL table, and blanken routineArray
        
        // Blanken SQLTable
        VisualizerDatabase.shared.deleteAllRows()
        
        // for each VisualizerRoutine in routinesArray, add to VisualizerDatabase
        for routine in routinesArray
        {
            VisualizerDatabase.shared.insert(name: routine.name, tag: routine.tag, image: routine.imageName, actions: "Sample", doneStatus: routine.isDone, progressStatus: routine.isInProgress)
        }
        
        // Empty RoutinesArray upon leaving the view
        routinesArray.removeAll()
    }
    
    // Tells Tableview how many cells will be generated
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return routinesArray.count
    }
    
    // Tells tableview what type of cells to generate and what their contents ares
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visualizerCell", for: indexPath) as! VisualizerTableViewCell
        
        // Assign from RoutinesArray to Cell
        cell.nameLabel.text = routinesArray[indexPath.row].name
        cell.tagLabel.text = routinesArray[indexPath.row].tag
        cell.imageViewLabel.image = UIImage(named: routinesArray[indexPath.row].imageName)
        
        return cell
    }
}


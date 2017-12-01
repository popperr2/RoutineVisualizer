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
    
    //---------------------------------------------------
    // Function: viewDidLoad()
    //---------------------------------------------------
    // Parameters: N/A
    //
    // Pre-Condition: view has been loaded by AppDelegate
    // Post-Condition: The tableview is created upon load
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: viewWillAppear()
    //---------------------------------------------------
    // Parameters:
    //      input Bool; animated
    //
    // Pre-Condition:   View has been switched to by User
    //                  using the UI
    // Post-Condition:  The SQLite Database is loaded into
    //                  the routineArray and data is
    //                  reloaded.
    //---------------------------------------------------
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
                
                temp = temp + 1
            }
        }
        
        self.tableView.reloadData()
    }
    
    //---------------------------------------------------
    // Function: viewWillDisappear()
    //---------------------------------------------------
    // Parameters:
    //      input Bool; animated
    //
    // Pre-Condition:   User has clicked off current view
    // Post-Condition:  SQLite Database will remove old
    //                  rows and add new rows from routine
    //                  array.
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: tableView()
    //---------------------------------------------------
    // Parameters:
    //      input UITableView, tableView
    //      input Int, the number of rows in table
    //
    // Pre-Condition:   tableView exists
    // Post-Condition:  Returns an integer of how many rows
    //                  there are based on RoutinesArray
    //---------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return routinesArray.count
    }
    
    //---------------------------------------------------
    // Function: tableView()
    //---------------------------------------------------
    // Parameters:
    //      input UITableView, tableView
    //      input IndexPath, indexPath
    //
    // Pre-Condition:   tableView exists
    // Post-Condition:  Returns a UITableViewCell that
    //                  is created through the method
    //                  and assigned to elements from
    //                  routinesArray
    //---------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visualizerCell", for: indexPath) as! VisualizerTableViewCell
        
        // Assign from RoutinesArray to Cell
        cell.nameLabel.text = routinesArray[indexPath.row].name
        cell.tagLabel.text = routinesArray[indexPath.row].tag
        cell.imageViewLabel.image = UIImage(named: routinesArray[indexPath.row].imageName)
        
        return cell
    }
    
    // DELETION Methods
   
    //---------------------------------------------------
    // Function: tableView()
    //---------------------------------------------------
    // Parameters:
    //      input UITableView, tableView
    //      input IndexPath, indexPath
    //
    // Pre-Condition:   tableView exists
    // Post-Condition:  Returns a Boolean stating if it
    //                  is okay or not to be able to edit
    //                  UITableViewCells
    //---------------------------------------------------
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //---------------------------------------------------
    // Function: tableView()
    //---------------------------------------------------
    // Parameters:
    //      input UITableView, tableView
    //      input UITableViewCellEditingStyle, the editing
    //      stlyle of the cell
    //      input IndexPath, indexPath
    //
    // Pre-Condition:   tableView exists
    // Post-Condition:  Removes deleted cells from both the
    //                  routinesArray and UITableView
    //---------------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        // Begin Updates
        routinesArray.remove(at: indexPath.row) // Remove from RoutineArray
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        // End Updates
    }
    
    //---------------------------------------------------
    // Function: tableView()
    //---------------------------------------------------
    // Parameters:
    //      input UITableView, table View
    //      input IndexPath, indexPath
    //
    // Pre-Condition:   tableView exists
    // Post-Condition:  Returns [UITableViewRowAction]
    //                  and changes its UI properties.
    //---------------------------------------------------
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteButton = UITableViewRowAction(style: .default, title: "Complete!") { (action, indexPath) in self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = UIColor(red:0.55, green:0.87, blue:0.51, alpha:1.0)
        return [deleteButton]
    }
}


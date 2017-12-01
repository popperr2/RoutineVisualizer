/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  RoutineManagerViewController.swift
 * File Description:  This View Controller contains the view for the routine manager where routines can be viewed or deleted.
 * Last Modified On: November 29, 2017
 * ----------------------------------------------*/

import UIKit
import SQLite

class RoutineManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // Class Variables
    private var tableView: UITableView!

    private var routinesArray: Array<Routine> = []      // Holds All Routines from SQL
    private var actionsArray: Array<Action> = []        // Reused array to add actions into routine
    
    // Runs the first time the view is loaded
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Add TableView and Settings to RoutinewViewController
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 150
        self.view.addSubview(tableView)
    }
    
    // Runs every time the view is going to appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // When the view is about to appear, the model will
        // update a blank routineArray based on SQL saved routines
        
        // For each Routine in RoutineManagerDatabaseQuery, add to RoutinesArray
        if let routineManagerDatabaseQuery: AnySequence<Row> = RoutineManagerDatabase.shared.queryAll()
        {
            var temp: Int = 1
            for eachRoutine in routineManagerDatabaseQuery
            {
                // Print SQL Contents
                RoutineManagerDatabase.shared.toString(routine: eachRoutine)
                
                // Add Attributes to RoutineHolder
                let routineHolder = Routine()                // Holds a Routine
                routineHolder.name = RoutineManagerDatabase.shared.queryName(id: Int64(temp))!
                routineHolder.tag = RoutineManagerDatabase.shared.queryTag(id: Int64(temp))!
                routineHolder.imageName = RoutineManagerDatabase.shared.queryImageName(id: Int64(temp))!
                
                // Temporary Actions
                let exampleAction = Action(name: "exampleAction", imageName: "sun", description: "exampleActionDescription")
                actionsArray.append(exampleAction)
                routineHolder.actions = actionsArray
                
                // Add RoutineHolder to routinesArray
                routinesArray.append(routineHolder)
                
                temp = temp + 1
            }
        }
        self.tableView.reloadData()
        
        // If there are no routines, alert the user
        if (routinesArray.isEmpty)
        {
            let noRoutinesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            noRoutinesLabel.center = self.view.center
            noRoutinesLabel.textAlignment = .center
            noRoutinesLabel.text = "No routines in database!"
            self.view.addSubview(noRoutinesLabel)
        }
    }
    
    // Runs every time the user clicks off the view
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // When the view is about to disappear, the model will
        // blanken SQL table, upload routineArray to SQL table, and blanken RoutineArray
        
        // TO DO: SQLTable Blanken
        RoutineManagerDatabase.shared.deleteAllRows()
        
        // For each Routine in RoutinesArray, add to RoutineManagerDatabase
        for routine in routinesArray
        {
            RoutineManagerDatabase.shared.insert(name: routine.name, tag: routine.tag, image: routine.imageName, actions: "Sample")
        }
        
        // Empty RoutinesArray Upon leaving the page
        routinesArray.removeAll()
    }
    
    // Tells tableView how many cells will be generated
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routinesArray.count
    }
    
    // Tells tableView what type of cells to generate and what their contents are
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Assign from RoutinesArray to Cell
        cell.nameLabel.text = routinesArray[indexPath.row].name
        cell.tagLabel.text = routinesArray[indexPath.row].tag
        cell.imageViewLabel?.image = UIImage(named: routinesArray[indexPath.row].imageName)
        
        return cell
    }
    
    // DELETION METHODS
    // Tells the TableView that cells can be edited / deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    // Delete cells and update the Arrays
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            //self.tableView.beginUpdates()
            routinesArray.remove(at: indexPath.row) // Remove from RoutineArray
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            //self.tableView.endUpdates()
        }
    }
}


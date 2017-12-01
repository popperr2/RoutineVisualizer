/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  GenerateVisualizerViewControllers.swift
 * File Description:  A View Controller that generates a Visualizer Schedule.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import SQLite
import UIKit

class GenerateVisualizerViewController: UIViewController
{
    // Class Variables
    @IBOutlet weak var tagTextInput: UITextField!   // User Input Tags #Example#Example#Exam
    @IBOutlet weak var generateButton: UIButton!    // SubmissionButton
    
    private var routinesArray: Array<VisualizerRoutine> = []  // Holds Routines
    private var actionsArray: Array<Action> = []
    
    // Runs the first time the view is loaded
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Button Setup
        generateButton.addTarget(self, action: #selector(generateButtonPress), for: .touchUpInside)
    }
    
    // Runs every time view is going to appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Model updates routineArray based on SQL Saved Routines
       if let routineManagerDatabaseQuery: AnySequence<Row> = RoutineManagerDatabase.shared.queryAll()
        {
            var temp: Int = 1
            for eachRoutine in routineManagerDatabaseQuery
            {
                // Add Attributes to RoutineHolder
                let routineHolder = VisualizerRoutine()              // Holds a Routine
                routineHolder.name = RoutineManagerDatabase.shared.queryName(id: Int64(temp))!
                routineHolder.tag = RoutineManagerDatabase.shared.queryTag(id: Int64(temp))!
                routineHolder.imageName = RoutineManagerDatabase.shared.queryImageName(id: Int64(temp))!
                
                // Temporary Actions
                let exampleAction = Action(name: "exampleAction", imageName: "sun", description: "exampleActionDescription")
                actionsArray.append(exampleAction)
                routineHolder.actions = actionsArray
                
                // Visualizer Variables
                routineHolder.isDone = false
                routineHolder.isInProgress = false
                
                // Add RoutineHolder to routinesArray
                routinesArray.append(routineHolder)
                
                temp = temp + 1
            }
        }
    }
    
    // Runs every time view is going to disappear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        //routinesArray.removeAll()
    }
    
    // User presses "generate" button
    @objc func generateButtonPress(sender: UIButton!)
    {
        let alertController = UIAlertController()
        alertController.title = "Submission Error"
        
        if(tagTextInput.text == "" || tagTextInput.text?.contains("#") == false) // User is did not add text to namefield
        {
            if (tagTextInput.text == "")    // left field blank
            {
                alertController.message = "Not all fields are filled out!"
            }
            else if (tagTextInput.text?.contains("#") == false) // Didn't format correctly
            {
                alertController.message = "Tag field does not contain # identifier"
            }
            
            // Add Alert to Users
            alertController.addAction(UIAlertAction(title:"Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else // User is not missing any details
        {
            print ("Button Press: All inputs were approved")
            print ("User inputs were: \(tagTextInput.text!)")
            
            let tagArray = tagTextInput.text?.split(separator: "#").map(String.init)
            
            // Search for routines with tag and put them into VisualizerDatabase
            for eachRoutine in routinesArray
            {
                if (tagArray?.contains(eachRoutine.tag))!
                {
                    VisualizerDatabase.shared.insert(name: eachRoutine.name, tag: eachRoutine.tag, image: eachRoutine.imageName, actions: "SampleAction", doneStatus: false, progressStatus: false)
                }
            }
            
            // Pop back to Visualizer View
            navigationController?.popViewController(animated: true)
        }
    }
}

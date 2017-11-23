/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: ActionsViewController.swift
 * File Description:  This ViewController manages Actions.  Testing
 * Last Modified On: November 4, 2017
 */

import UIKit

// Testing Functionality
class ActionsViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = UIColor.blue;  // Change the ViewController background color
        
        // Try to get routinestep to appear and be able to scroll
        // Make routinestep object and set properties
        let myRoutineStep = RoutineStep()
        myRoutineStep.stepDescription = "ExampleText ExampleText ExampleText"
        myRoutineStep.stepImage = #imageLiteral(resourceName: "stepImageTemp1")
        
        // Draw it onto the viewcontroller
        let imageView = UIImageView(image: myRoutineStep.stepImage)
        
        view.addSubview(imageView)
        
    }
}

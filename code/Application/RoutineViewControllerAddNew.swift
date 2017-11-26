/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: RoutineViewControllerAddNew.swift
 * File Description:  Manages SQL Connections
 * Last Modified On: November 24, 2017
 */

import UIKit

class RoutineViewControllerAddNew: UIViewController {

    // Class Variables
    @IBOutlet weak var nameTextField: UITextField!  // The text field that takes in the User's Input for the Routine Name
    @IBOutlet weak var tagTextField: UITextField!  // The text field that takes in the User's Input for the Routine Tag
    @IBOutlet weak var submissionButton: UIButton!  // The Submission button of the information that causes the push to RoutineDatabase table
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Get Text:  nameTextField.text
        
    }
    @IBAction func submitRoutine(_ sender: Any)
    {
        if nameTextField.text == ""
        {
            nameTextField.text = "nil"
        }
        if tagTextField.text == ""
        {
            tagTextField.text = "nil"
        }
        
        RoutineDatabase.shared.insert(name: nameTextField.text!, tag: tagTextField.text!)
        
        navigationController?.popViewController(animated: true)
    }
}

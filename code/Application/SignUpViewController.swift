/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: LoginViewController.swift
 * File Description:  This ViewController manages the Login View.
 * Last Modified On: November 4, 2017
 */

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // onClick, the button goes back to LoginViewController
    @IBAction func dismiss_onClick(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}

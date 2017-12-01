/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  AddNewRoutineViewController.swift
 * File Description:  This View Controller contains the view for adding new routines to the RoutineManager.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import Foundation
import SQLite

class AddNewRoutineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // Class Variables
    var collectionView: UICollectionView?
    
    @IBOutlet weak var routineNameTextField: UITextField!
    @IBOutlet weak var routineTagTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var selectedImage: String!
    
    var imageNameArray = ["sun", "moon", "sun", "sun", "moon", "moon", "sun"]
    
    // Runs as it is loaded the first time
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Set Up Routine Image Selection
        // Set Up CollectionView
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 200), collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 160.0).isActive = true
        collectionView?.widthAnchor.constraint(equalToConstant: 400).isActive = true
        collectionView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView?.backgroundColor = UIColor.lightGray
        
        //CollectionViewFlowLayout Setup
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.itemSize = CGSize.init(width: 150, height: 150)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 20
        
        // Collection View Settings
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.reloadData()
        
        // TO DO: Set Up Routine Actions Selection
    }
    
    // User clicks Submission Button
    @IBAction func submitButtonPress(_ sender: Any)
    {
        print (selectedImage)
        let alertController = UIAlertController()
        alertController.title = "PLEASE FILL OUT ALL FIELDS"
        // User is missing a detail
        if (routineNameTextField.text == "" || routineTagTextField.text == "" || selectedImage == nil)
        {
            if (routineNameTextField.text == "" && routineTagTextField.text != "" && selectedImage != nil)
            {
                alertController.message = "Missing field for Routine Name."
            }
            else if (routineTagTextField.text == "" && routineNameTextField.text != "" && selectedImage != nil)
            {
                alertController.message = "Missing field for Routine Tag."
            }
            else if (selectedImage == nil && routineTagTextField.text != "" && routineNameTextField.text != "")
            {
                alertController.message = "Missing selection of Routine Image"
            }
            else // Multiple fields are not filled out
            {
                alertController.message = "Multiple fields are missing"
            }
            alertController.addAction(UIAlertAction(title:"Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else // user is not missing any details
        {
            print ("Button Press: All the user inputs were approved")
            print ("User inputs were: \(routineNameTextField.text!), \(routineTagTextField.text!), \(selectedImage!), and SampleAction")
            
            // Insert Into SQL Database
            RoutineManagerDatabase.shared.insert(name: routineNameTextField.text!, tag: routineTagTextField.text!, image: selectedImage!, actions: "SampleAction")
            
            // Pop back to RoutineManager View
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    // COLLECTION VIEW FUNCTIONS
    // Determines how many collection view cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imageNameArray.count
    }
    
    // Create Image Cells in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath)
        
        // Cell Setup
        let cellImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        let imageName = imageNameArray[indexPath.row]
        cellImageView.image = UIImage(named: imageName)
        cell.contentView.addSubview(cellImageView)
        
        return cell
    }
    
    // When selecting a cell in collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)
        
        // On Selection UI Change
        cell?.layer.borderWidth = 5.0
        cell?.layer.borderColor = UIColor.red.cgColor
        
        selectedImage = imageNameArray[indexPath.row]
    }
    
    // Unselect Image when selecting another image
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 0.0
    }
}

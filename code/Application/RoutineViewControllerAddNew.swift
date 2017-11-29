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
import SQLite

class RoutineViewControllerAddNew: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Class Variables
    var imageNameArray = ["stepImageTemp1", "stepImageTemp2", "stepImageTemp3", "stepImageTemp4"]
    
    var collectionView: UICollectionView?
    let cellId = "imageCell"
    let cellSpacing: CGFloat = 10
    let cellWidth: Int = 150
    let cellHeight: Int = 150
    
    var selectedImage: String? // What image was selected
    
    @IBOutlet weak var nameTextField: UITextField!  // The text field that takes in the User's Input for the Routine Name
    @IBOutlet weak var tagTextField: UITextField!  // The text field that takes in the User's Input for the Routine Tag
    @IBOutlet weak var submissionButton: UIButton!  // The Submission button of the information that causes the push to RoutineDatabase table
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do something after the view loads
    }
    
    // Runs before a view is displayed
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Set Up Collectionview
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 200), collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        //collectionView?.center = self.view.center
        collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 160.0).isActive = true
        collectionView?.widthAnchor.constraint(equalToConstant: 400).isActive = true
        collectionView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView?.backgroundColor = UIColor.blue
        
        // CollectionViewFlowLayout Settings
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.itemSize = CGSize.init(width: 150, height: 150)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = cellSpacing + 10
        
        // Collection View Settings
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    // How many image cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    // Create the image cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        // Cell Setup
        cell.backgroundColor = .black
        
        let cellImageView = UIImageView(frame: CGRect(x:0, y: 0, width: cellWidth, height: cellHeight))
        let imageName = imageNameArray[indexPath.row]
        cellImageView.image = UIImage(named: imageName)
        //cellImageView.image = imageArray[indexPath.row]
        cell.contentView.addSubview(cellImageView)
        
        return cell
    }
    
    // Select an Image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5.0
        cell?.layer.borderColor = UIColor.red.cgColor
        
        // What image is this cell
        selectedImage = imageNameArray[indexPath.row]
        
        //print(selectedImage)
    }
    
    // Unselect an Image when selecting another
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
    }
    
    // Submit the routine that the user selects
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
        
        RoutineDatabase.shared.insert(name: nameTextField.text!, tag: tagTextField.text!, image: selectedImage!)
        navigationController?.popViewController(animated: true)
    }
}

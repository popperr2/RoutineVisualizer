/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: RoutineViewController.swift
 * File Description:  This ViewController manages routines and can add new ones.
 * Last Modified On: November 26, 2017
 */

import UIKit
import SQLite

class RoutineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // Class Variables
    var collectionView: UICollectionView?           // An object that holds the cells
    let cellId = "ExampleCell"                      // An ID used by the cell
    let cellSpacing:CGFloat = 10                    // The amount of spacing between cells
    
    var selectedCell: Int?
    
    // Runs the first time the view loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create Edit Button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // Runs right before a view is displayed each time
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Set up CollectionView
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.backgroundColor = UIColor.white
        
        // CollectionViewFlowLayout Settings
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: cellSpacing + 5, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpacing + 5  // Spacing Between Cells
        collectionViewFlowLayout.minimumLineSpacing = cellSpacing + 5   // Spacing Between Cells
        
        // Collection View Settings
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        setupDatabases()
        
        // If no routines are added, tell the user
        var temp = 0
        if let routineDatabaseQuery: AnySequence<Row> = RoutineDatabase.shared.queryAll()
        {
            for eachRoutine in routineDatabaseQuery
            {
                temp = temp + 1
                if (temp > 0)
                {
                    break
                }
            }
        }
        if temp == 0
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            label.center = self.view.center
            label.text = "No Routines"
            //self.view.addSubview(label)
            collectionView?.addSubview(label)
        }
    }
    
    // Prints out database info for testing purposes
    func setupDatabases()
    {
        if let routineDatabaseQuery: AnySequence<Row> = RoutineDatabase.shared.queryAll()
        {
            for eachRoutine in routineDatabaseQuery {
                // print database information
                RoutineDatabase.shared.toString(routine: eachRoutine)
            }
        }
    }
    
    // Collection View Data Source:  Controls the number of cells in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // Reach into SQLite Table and figure out how many routines in total exist
        var temp = 0
        if let routineDatabaseQuery: AnySequence<Row> = RoutineDatabase.shared.queryAll()
        {
            for eachRoutine in routineDatabaseQuery
            {
                temp = temp + 1
            }
        }
        return temp
    }
    
    // Collection View controller, creation of contents of cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var id: Int64 = RoutineDatabase.shared.findCorrectId(index: indexPath.row)!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let cellWidth: CGFloat = cell.contentView.bounds.size.width     // The width of the created cell
        let cellHeight: CGFloat = cell.contentView.bounds.size.height   // The height of the created cell
        
        // Cell Setup
        cell.backgroundColor = .green
        
        // Add Image using SQL identifier
        let cellImageView = UIImageView(frame: CGRect(x: 20, y: (cellHeight / 10), width: cellHeight * 0.8, height: cellHeight * 0.8))
        let imageName: String = RoutineDatabase.shared.queryImage(id: id)!
        cellImageView.image = UIImage(named: imageName)
        cell.contentView.addSubview(cellImageView)
        
        // Add Routine Name Label
        let cellTitle = UILabel(frame: CGRect(x: (cellWidth / 2), y: (cellHeight / 10), width: (cellWidth/2) - 2, height: 40))
        cellTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        cellTitle.numberOfLines = 2
        cellTitle.text = "NAME: \n" + (RoutineDatabase.shared.queryName(id: id)?.uppercased())!
        cellTitle.sizeToFit()
        cell.contentView.addSubview(cellTitle)
        
        // Add Routine Tag Label
        let cellTag = UILabel(frame: CGRect(x: (cellWidth / 2), y: cellHeight - 50, width: cell.bounds.size.width, height: 40))
        cellTag.text = "TAG: " + RoutineDatabase.shared.queryTag(id: id)!
        cell.contentView.addSubview(cellTag)
        
        return cell
    }
    
    // Settings for cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing)
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    
    // On select image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // If the editing button is selected
        let cell = collectionView.cellForItem(at: indexPath)
        selectedCell = indexPath.row
        
        if (isEditing)  // If you're editing
        {
            // You can't select the image multiple times
            let blurRemove = cell?.contentView.viewWithTag(11)
            blurRemove?.removeFromSuperview()
            
            // Create Blur Effect When Selecting
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = (cell?.contentView.bounds)!
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.tag = 11
            cell?.contentView.addSubview(blurEffectView)
            
            // Create DeleteButton
            let deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            deleteButton.backgroundColor = UIColor.red
            deleteButton.setTitle("Delete", for: .normal)
            deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
            deleteButton.tag = 10
            cell?.contentView.addSubview(deleteButton)
        }
    }
    
    // DeleteButton
    @objc func deleteButtonAction(sender: UIButton!)
    {
        // TO DO:  ADD DELETE FUNCTION
        var selection: Int64 = RoutineDatabase.shared.findCorrectId(index: selectedCell!)!
        RoutineDatabase.shared.delete(deleteId: selection)
        
        //print (selectedCell)
    }
    
    // Unselect an Image when selecting another
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        // Remove blur effect when deselecting
        let blurRemove = cell?.contentView.viewWithTag(11)
        blurRemove?.removeFromSuperview()
        
        let deleteButtonRemove = cell?.contentView.viewWithTag(10)
        deleteButtonRemove?.removeFromSuperview()
    }
    
}

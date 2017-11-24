/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: ActionsViewController.swift
 * File Description:  This ViewController manages Actions.
 * Last Modified On: November 4, 2017
 */

import UIKit

class ActionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // Class Variables
    var collectionView: UICollectionView?           // An object that holds the cells
    let cellId = "ExampleCell"                      // An ID used by the cell
    let cellSpacing:CGFloat = 10                    // The amount of spacing between cells

    // View Did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }
    
    // Collection View Data Source:  Controls the number of cells in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // The Number of Cells there are in the collection view
        // Reach into SQLite and figure out how many steps there are in the selected routine.
        return 5
    }
    
    // Defines contents of cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        // Cell Setup
        cell.backgroundColor = .green
        
        // Add Image
        let cellImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        cellImageView.image = #imageLiteral(resourceName: "stepImageTemp1")
        cell.contentView.addSubview(cellImageView)
        
        // Add Label / Text
        let cellTitle = UILabel(frame: CGRect(x: 150, y: 0, width: cell.bounds.size.width, height: 40))
        cellTitle.text = "Smoogle"
        cell.contentView.addSubview(cellTitle)
        
        return cell
    }
    
    // Settings for cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing)
        let height = width / 2
        return CGSize(width: width, height: height)
    }
}


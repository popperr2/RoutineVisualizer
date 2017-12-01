/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  Database.swift
 * File Description:  This file creates a database in SQL for the program to use.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import Foundation
import SQLite

class Database
{
    // Class Variables
    static let shared = Database()
    public let connection: Connection?
    public let databaseFileName = "database.sqlite3"
    
    //---------------------------------------------------
    // Function: init()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   SQLite Cocoapods have been installed
    // Post-Condition:  Creates a Database to store tables
    //                  and establishes a connection
    //---------------------------------------------------
    private init()
    {
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
        do {
            connection = try Connection("\(dbPath!)/(databaseFileName)")
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}

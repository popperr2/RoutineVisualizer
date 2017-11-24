/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: Database.swift
 * File Description:  This file manages SQL Connections
 * Last Modified On: November 24, 2017
 */

import Foundation
import SQLite

// Sets up the database feature of Swift
class Database
{
    static let shared = Database()
    public let connection: Connection?
    public let databaseFileName = "database.sqlite3"
    private init()
    {
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first as String!
        do {
            connection = try Connection("\(dbPath!)/(databaseFileName)")
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}

/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: Database.swift
 * File Description:  Manages SQL Connections
 * Last Modified On: November 24, 2017
 */

/*import Foundation
import SQLite

class ActionsEntity
{
    static let shared = ActionsEntity()
    
    private let tblActions = Table("tblActions")
    
    private let id = Expression<Int64>("id")
    private let name = Expression<Int64>("name")
    private let stepIdentifier = Expression<String>("stepIdentifier")
    
    private init()
    {
        // Create table if it doesn't exist
        do
        {
            if let connection = Database.shared.connection
            {
                try connection.run(tblActions.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.name)
                    table.column(self.stepIdentifier)
                }))
                print ("Created table tblActions successfully")
            } else {
                print ("Creating table tblActions failed.")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblActions failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func toString(action: Row)
    {
        print ("""
            Action Details.  Name = \(action[self.name]),\
            Step Identifier = \(action[self.stepIdentifier]))
            """)
    }
}*/

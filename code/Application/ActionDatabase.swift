/* Name: Rebecca Popper
 * Course: CSC 415
 * Semester: Fall 2017
 * Instructor: Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see their daily schedule in visual form.
 * Filename: ActionDatabase.swift
 * File Description:  Manages SQL Connections
 * Last Modified On: November 24, 2017
 */

// This contains the list of stored routines in total (not those just in daily schedule)

import Foundation
import SQLite

class ActionDatabase
{
    static let shared = ActionDatabase()
    
    private let tblActionDatabase = Table("tblActionDatabase")
    
    private let id = Expression<Int64>("id")
    private let actionName = Expression<String>("actionName")
    
    private init()
    {
        // Create the table if it doesn't exist already
        do
        {
            if let connection = Database.shared.connection
            {
                try connection.run(tblActionDatabase.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {(table) in table.column(self.id, primaryKey: true)
                    table.column(self.actionName)
                }))
                print ("Created table tblActionDatabase successfully")
            }
            else
            {
                print ("Creating table tblActionDatabase failed.")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblActionDatabase failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func toString(action: Row)
    {
        print   ("""
            RoutineDatabase Details.  id = \(action[self.id]),
            Name = \(action[self.actionName])
            """)
    }
    
    // Insert a routine into the routine total database
    func insert(name: String, tag: String) -> Int64?
    {
        do
        {
            let insert = tblActionDatabase.insert(self.actionName <- name)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print ("Cannot insert an Action to the Action Database.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Query / find all records in table
    func queryAll() -> AnySequence<Row>?
    {
        do
        {
            return try Database.shared.connection?.prepare(self.tblActionDatabase)
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    func queryName(id: Int64) -> String?
    {
        do
        {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblActionDatabase.filter(self.id == id)))!
            
            for eachAction in thing {
                // print
                return eachAction[self.actionName]
            }
            
        } catch {
            let nserror = error as NSError
            print ("Cannot query name of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
}


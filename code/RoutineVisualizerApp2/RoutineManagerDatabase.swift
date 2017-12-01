/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  RoutineManagerDatabase.swift
 * File Description:  An SQL table class that manages the total routines in the database.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import Foundation
import SQLite

class RoutineManagerDatabase
{
    static let shared = RoutineManagerDatabase()
    
    private let tblRoutineManagerDatabase = Table("tblRoutineManagerDatabase")
    
    // Variables in the Table
    private let id = Expression<Int64>("id")                                // Primary Key ID
    private let routineName = Expression<String>("routineName")             // Routine Name
    private let routineTag = Expression<String>("routineTag")               // Routine Tag
    private let routineImageName = Expression<String>("routineImageName")   // Name of Routine Image
    private let actionArrayString = Expression<String>("actionArrayString") // Array of Routine Actions, parsed into a string
    
    // Intialize table if not already done
    private init()
    {
        // Create the table if it doesn't exist already
        do {
            if let connection = Database.shared.connection
            {
                try connection.run(tblRoutineManagerDatabase.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {(table) in table.column(self.id, primaryKey: true)
                    table.column(self.routineName)
                    table.column(self.routineTag)
                    table.column(self.routineImageName)
                    table.column(self.actionArrayString)
                }))
                print ("Created table tblRoutineManagerDatabase successfully")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblRoutineManagerDatabase failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Print out contents of database
    func toString(routine: Row)
    {
        print   ("""
                RoutineManagerDatabaseDetails.  id = \(routine[self.id]),
                Routine Name = \(routine[self.routineName]),
                Routine Tag = \(routine[self.routineTag]),
                Routine Image Name = \(routine[self.routineImageName]),
                Routine Action Array As String = \(routine[self.actionArrayString])
                """)
    }
    
    // Insert a routine into tblRoutineManagerDatabase
    func insert(name: String, tag: String, image: String, actions: String) -> Int64?
    {
        do {
            let insert = tblRoutineManagerDatabase.insert(self.routineName <- name, self.routineTag <- tag, self.routineImageName <- image, self.actionArrayString <- actions)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print ("Cannot insert a Routine to RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Query All Records in tblRoutineManagerDatabase
    func queryAll() -> AnySequence<Row>?
    {
        do {
            return try Database.shared.connection?.prepare(self.tblRoutineManagerDatabase)
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Get Name
    func queryName(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineManagerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineName]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get Tag
    func queryTag(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineManagerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineTag]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get ImageName
    func queryImageName(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineManagerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineImageName]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get Actions Array
    func queryActionArrayString(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineManagerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.actionArrayString]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Delete all rows in tblRoutineManagerDatabase
    func deleteAllRows()
    {
        do {
            try Database.shared.connection?.run(self.tblRoutineManagerDatabase.delete())
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table RoutineManagerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}

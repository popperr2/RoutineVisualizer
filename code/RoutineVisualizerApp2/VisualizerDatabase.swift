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

class VisualizerDatabase
{
    static let shared = VisualizerDatabase()
    
    private let tblVisualizerDatabase = Table("tblVisualizerDatabase")
    
    // Variables in the Table
    private let id = Expression<Int64>("id")                                    // Primary Key ID
    private let routineName = Expression<String>("routineName")                 // Routine Name
    private let routineTag = Expression<String>("routineTag")                   // Routine Tag
    private let routineImageName = Expression<String>("routineImageName")       // Routine Image Name
    private let actionArrayString = Expression<String>("actionArrayString")     // Action Array as a String
    private let routineIsDone = Expression<Bool>("routineIsDone")               // Is Done
    private let routineIsInProgress = Expression<Bool>("routineIsInProgress")   // Is In Progress
    
    // Intialize Table If Not Already Done
    private init()
    {
        // Create table if it doesn't already exist
        do
        {
            if let connection = Database.shared.connection
            {
                try connection.run(tblVisualizerDatabase.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {(table) in table.column(self.id, primaryKey: true)
                    table.column(self.routineName)
                    table.column(self.routineTag)
                    table.column(self.routineImageName)
                    table.column(self.actionArrayString)
                    table.column(self.routineIsDone)
                    table.column(self.routineIsInProgress)
                }))
                print ("Created table tblVisualizerDatabase successfully")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblVisualizerDatabase failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Print out contents of database
    func toString(routine: Row)
    {
        print   ("""
                VisualizerDatabaseDetails.  id = \(routine[self.id]),
                Routine Name = \(routine[self.routineName]),
                Routine Tag = \(routine[self.routineTag]),
                Routine Image Name = \(routine[self.routineImageName]),
                Routine Action Array As String = \(routine[self.actionArrayString]),
                Routine isDoneStatus = \(routine[self.routineIsDone]),
                Routine isInProgressStatus = \(routine[self.routineIsInProgress])
                """)
    }
    
    // Insert a routine into tblVisualizerDatabase
    func insert(name: String, tag: String, image: String, actions: String, doneStatus: Bool, progressStatus: Bool) -> Int64?
    {
        do {
            let insert = tblVisualizerDatabase.insert(self.routineName <- name, self.routineTag <- tag, self.routineImageName <- image, self.actionArrayString <- actions, self.routineIsDone <- doneStatus, self.routineIsInProgress <- progressStatus)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print ("Cannot insert a Routine to VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Query All Records in tblVisualizerDatabase
    func queryAll() -> AnySequence<Row>?
    {
        do {
            return try Database.shared.connection?.prepare(self.tblVisualizerDatabase)
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Get Name
    func queryName(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineName]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Name in table VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get Tag
    func queryTag(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineTag]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Tag in table VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get ImageName
    func queryImageName(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineImageName]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Image Name in table VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get Actions Array
    func queryActionArrayString(id: Int64) -> String?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.actionArrayString]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query Routine Actions in table VisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    // Get isDone Status
    func queryIsDone(id: Int64) -> Bool?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineIsDone]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query isDoneStatus in table tblVisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        return nil
    }
    
    // Get isInProgress Status
    func queryIsInProgress(id: Int64) -> Bool?
    {
        do
        {
            let table: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblVisualizerDatabase.filter(self.id == id)))!
            
            for eachRoutine in table
            {
                return eachRoutine[self.routineIsInProgress]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query isInProgress in table tblVisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        return nil
    }
    
    // Delete all rows in tblVisualizerDatabase
    func deleteAllRows()
    {
        do
        {
            try Database.shared.connection?.run(self.tblVisualizerDatabase.delete())
        } catch {
            let nserror = error as NSError
            print ("Cannot delete rows in table tblVisualizerDatabase.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}

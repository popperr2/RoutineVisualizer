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
    
    //---------------------------------------------------
    // Function: init()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   Database exists
    // Post-Condition:  Create table for VisualizerData
    //                  if does not already exist.
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: toString()
    //---------------------------------------------------
    // Parameters:
    //      input Row, a row in the table
    //
    // Pre-Condition:   A row exists in the table
    // Post-Condition:  Print out the contents of selected
    //                  Row in String form
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: insert()
    //---------------------------------------------------
    // Parameters:
    //      input String, name of Routine
    //      input String, tag of Routine
    //      input String, name of Routine Image
    //      input String, actions of Routine
    //      input doneStatus, status of being Done
    //      input progressStatus, status of Progress
    //
    // Pre-Condition:   Table exists to insert rows to
    // Post-Condition:  Creates a new row with the information
    //                  given about the routine.
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryAll()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries all the data in the table
    //                  and returns an AnySequence<Row>
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryName()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the name String of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryTag()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the tag String of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryImageName()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the image name String of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryActionArrayStrings()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the actions String of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryIsDone()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the Bool isDone of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: queryIsInProgress()
    //---------------------------------------------------
    // Parameters:
    //      input Int64, the primaryKey row Id number
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Queries the data in the table
    //                  and returns the Bool isInProgress of
    //                  the selected row
    //---------------------------------------------------
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
    
    //---------------------------------------------------
    // Function: deleteAllRows()
    //---------------------------------------------------
    // Parameters:  None
    //
    // Pre-Condition:   Table exists in database
    // Post-Condition:  Deletes all rows in the table
    //---------------------------------------------------
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

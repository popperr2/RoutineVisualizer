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

// This contains the list of stored routines in total (not those just in daily schedule)

import Foundation
import SQLite

class RoutineDatabase
{
    static let shared = RoutineDatabase()
    
    private let tblRoutineDatabase = Table("tblRoutineDatabase")
    
    private let id = Expression<Int64>("id")
    private let routineName = Expression<String>("routineName")
    private let routineTag = Expression<String>("routineTag")
    
    private init()
    {
        // Create the table if it doesn't exist already
        do
        {
            if let connection = Database.shared.connection
            {
                try connection.run(tblRoutineDatabase.create(temporary: false, ifNotExists: true, withoutRowid: false, block: {(table) in table.column(self.id, primaryKey: true)
                    table.column(self.routineName)
                    table.column(self.routineTag)
                }))
                print ("Created table tblRoutineDatabase successfully")
            }
            else
            {
                print ("Creating table tblRoutineDatabase failed.")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblRoutineDatabase failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func toString(routine: Row)
    {
        print   ("""
                RoutineDatabase Details.  id = \(routine[self.id]),
                Name = \(routine[self.routineName]),
                Tag = \(routine[self.routineTag])
                """)
    }
    
    // Insert a routine into the routine total database
    func insert(name: String, tag: String) -> Int64?
    {
        do
        {
            let insert = tblRoutineDatabase.insert(self.routineName <- name, self.routineTag <- tag)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print ("Cannot insert a Routine to the Routine Database.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Query / find all records in table
    func queryAll() -> AnySequence<Row>?
    {
        do
        {
            return try Database.shared.connection?.prepare(self.tblRoutineDatabase)
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Func QueryID
    
    func queryName(id: Int64) -> String?
    {
        do
        {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.filter(self.id == id)))!
            
            for eachRoutine in thing {
                // print
                return eachRoutine[self.routineName]
            }
            
        } catch {
            let nserror = error as NSError
            print ("Cannot query name of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
    
    func queryTag(id: Int64) -> String?
    {
        do
        {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.filter(self.id == id)))!
            
            for eachRoutine in thing {
                // print
                return eachRoutine[self.routineTag]
            }
            
        } catch {
            let nserror = error as NSError
            print ("Cannot query name of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
}

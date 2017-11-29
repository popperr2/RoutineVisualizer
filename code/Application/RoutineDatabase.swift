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

import Foundation
import SQLite

class RoutineDatabase
{
    static let shared = RoutineDatabase()
    
    private let tblRoutineDatabase = Table("tblRoutineDatabase")
    
    private let id = Expression<Int64>("id")
    private let routineName = Expression<String>("routineName")
    private let routineTag = Expression<String>("routineTag")
    private let routineImage = Expression<String>("routineImage")
    
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
                    table.column(self.routineImage)
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
                Tag = \(routine[self.routineTag]),
                Image = \(routine[self.routineImage])
                """)
    }
    
    // Delete Record
    // TO DO: This
    func delete(deleteId: Int64)
    {
        do {
            let deleteRow = tblRoutineDatabase.filter(id == deleteId)
            //deleteRow.delete()
            try Database.shared.connection!.run(deleteRow.delete())
            
            // Renumber rows
            // TO DO: Renumber rows
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.filter(self.id == id)))!
            
            /*for (index, eachRoutine) in thing.enumerated()
            {
                
            }*/
            
        } catch {
            let nserror = error as NSError
            print ("Cannot insert a Routine to the Routine Database.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    // Insert a routine into the routine total database
    func insert(name: String, tag: String, image: String) -> Int64?
    {
        do
        {
            let insert = tblRoutineDatabase.insert(self.routineName <- name, self.routineTag <- tag, self.routineImage <- image)
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
    
    // Query MaxID
    func queryMaxId() -> Int64?
    {
        do {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.order([self.id])))!
            
            var temp: Int64 = 0
            for something in thing
            {
                temp = something[self.id]
            }
            return temp
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        return nil
    }
    
    func findCorrectId(index: Int) -> Int64?
    {
        do {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.order([self.id])))!
            
            var idToUse: Int64 = 0
            
            var i: Int = 0
            for id in thing
            {
                if index == i
                {
                    idToUse = id[self.id]
                    break
                }
                i = i + 1
            }
            
            return idToUse
        } catch {
            let nserror = error as NSError
            print ("Cannot query all of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        return nil
    }
    
    // Func Query Name
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
    
    func queryImage(id: Int64) -> String?
    {
        do
        {
            let thing: AnySequence<Row> = (try Database.shared.connection?.prepare(self.tblRoutineDatabase.filter(self.id == id)))!
            
            for eachRoutine in thing {
                return eachRoutine[self.routineImage]
            }
        } catch {
            let nserror = error as NSError
            print ("Cannot query name of table RoutineDatabase.  Error is: \(nserror), \(nserror.userInfo)")
            return "nil"
        }
        return "nil"
    }
}

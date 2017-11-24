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


// This is a table that makes up the daily schedule.  It is made up of Routine identifiers.
import Foundation
import SQLite

class DailyScheduleEntity
{
    static let shared = DailyScheduleEntity()
    
    private let tblDailySchedule = Table("tblDailySchedule")
    
    private let id = Expression<Int64>("id")
    private let routineName = Expression<String>("routineName")
    
    private init()
    {
        // Create the table if it doesn't exist already
        do
        {
            if let connection = Database.shared.connection
            {
                try connection.run(tblDailySchedule.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.routineName)
                }))
                print ("Created table tblDailySchedule successfully")
            }
            else
            {
                print ("Creating table tblDailySchedule failed.")
            }
        } catch {
            let nserror = error as NSError
            print ("Create table tblDailySchedule failed.  Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func toString(schedule: Row)
    {
        print   ("""
                Daily Schedule Details.  Name = \(schedule[self.routineName])
                """)
    }
    
    // Insert a routineIdentifier into the daily schedule database
    func insert(name: String) -> Int64?
    {
        do
        {
            let insert = tblDailySchedule.insert(self.routineName <- name)
            let insertedId = try Database.shared.connection!.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print ("Cannot insert new Routine Identifier.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    // Query / Find all records in tblDailySchedule
    func queryAll() -> AnySequence<Row>?
    {
        do
        {
            return try Database.shared.connection?.prepare(self.tblDailySchedule)
        } catch {
            let nserror = error as NSError
            print ("Cannot query all tblDailySchedule.  Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
}






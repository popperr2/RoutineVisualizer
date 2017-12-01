/* ----------------------------------------------*
 * Name:  Rebecca Popper
 * Course:  CSC 415
 * Semester:  Fall 2017
 * Instructor:  Dr. Pulimood
 * Project Name:  Routine Visualizer
 * Project Description:  A mobile application that allows the user to see routines that they should complete that day.
 * Filename:  AddNewRoutineViewController.swift
 * File Description:  This View Controller contains the view for adding new routines to the RoutineManager.
 * Last Modified On: November 30, 2017
 * ----------------------------------------------*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    //---------------------------------------------------
    // Function: applictation()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //      input UIApplicationLaunchOptionsKey
    //
    // Pre-Condition:   None
    // Post-Condition:  Returns a Boolean if application
    //                  has launched
    //---------------------------------------------------
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        return true
    }

    //---------------------------------------------------
    // Function: applictationWillResignActive()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //
    // Pre-Condition:   Application is about to move into
    //                  an inactive state.
    // Post-Condition:  None
    //---------------------------------------------------
    func applicationWillResignActive(_ application: UIApplication)
    {
    }
    
    //---------------------------------------------------
    // Function: applictation()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //      input UIApplicationLaunchOptionsKey
    //
    // Pre-Condition:   None
    // Post-Condition:  Returns a Boolean if application
    //                  has launched
    //---------------------------------------------------
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    //---------------------------------------------------
    // Function:
    //
    // Parameters:
    //
    // Pre-Condition:
    //
    // Post-Condition:
    //---------------------------------------------------
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //---------------------------------------------------
    // Function:
    //
    // Parameters:
    //
    // Pre-Condition:
    //
    // Post-Condition:
    //---------------------------------------------------
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //---------------------------------------------------
    // Function:
    //
    // Parameters:
    //
    // Pre-Condition:
    //
    // Post-Condition:
    //---------------------------------------------------
    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


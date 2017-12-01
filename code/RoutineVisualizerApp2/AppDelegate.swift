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
    // Function: applictationDidEnterBackground()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //
    // Pre-Condition:   None
    // Post-Condition:  None
    //---------------------------------------------------
    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }

    //---------------------------------------------------
    // Function: applictationWillEnterForeground()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //
    // Pre-Condition:   Transition from background to
    //                  active state
    // Post-Condition:  None
    //---------------------------------------------------
    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }

    //---------------------------------------------------
    // Function: applictationDidBecomeActive()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //
    // Pre-Condition:   Leave pause states
    // Post-Condition:  None
    //---------------------------------------------------
    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }

    //---------------------------------------------------
    // Function: applictationWillTerminate()
    //---------------------------------------------------
    // Parameters:
    //      input UIApplication
    //
    // Pre-Condition:   Application is about to terminate
    // Post-Condition:  None
    //---------------------------------------------------
    func applicationWillTerminate(_ application: UIApplication)
    {
    }
}


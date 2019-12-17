//
//  AppDelegate.swift
//  FinalChallengeApp
//
//  Created by George Joseph Kristian on 11/11/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CoreData
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let preloadedDataKey = "didPreloadData"
        let userIDUserDef = "userID"
        let therapistNameUserDef = "therapistName"
        let userDefaults = UserDefaults.standard
        
        //tabbar styling
        UITabBar.appearance().tintColor = UIColor(red: 0.73, green: 0.52, blue: 0, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray

        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            // check if it's the firsttime user open the app
            preloadData { (userRef, therapistName) in
                // setUserDefaults
                userDefaults.set(therapistName, forKey: therapistNameUserDef)
                userDefaults.set(userRef, forKey: userIDUserDef)
                ProfileTherapistCKModel.checkTherapistData(userRef: userRef) { (dataTherapistAvailability) in
                    // check data availability about therapist
                    if !dataTherapistAvailability{
                        print("no data therapist, appDelegate")
                        ProfileTherapistCKModel.addNewTherapist(therapistName: therapistName, userReference: userRef){
                            (newTherapistSaved) in
                            print(newTherapistSaved)
                        }
                        // create new one data therapist if it's not available
                        print("userID set at userDefaults")
                    } else{
                        print("data available therapist, appDelegate")
                    }
                    print("userID & therapistName : \(userDefaults.string(forKey: userIDUserDef)) & \(userDefaults.string(forKey: therapistNameUserDef))")
                    userDefaults.set(true, forKey: preloadedDataKey) // dont forget to set true
                }
            }
        }
        // Override point for customization after application launch.
        return true
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    
    private func preloadData(onComplete: @escaping(String,String) -> ()){
        print("masuk")
        var therapistName : String = ""
        var userRef : String = ""
        
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in
            CKContainer.default().fetchUserRecordID { (record, error) in
                guard let record = record else {return}
                CKContainer.default().discoverUserIdentity(withUserRecordID: record) { (userID, error) in
                    if let userID = userID {
                        userRef = "\(userID.userRecordID?.recordName ?? "")"
                        therapistName = "\(userID.nameComponents?.givenName ?? "") \(userID.nameComponents?.familyName ?? "")"
                        print(therapistName, userRef)
                        onComplete(userRef,therapistName)
                    }
                }
            }
        }
    }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "FinalChallengeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


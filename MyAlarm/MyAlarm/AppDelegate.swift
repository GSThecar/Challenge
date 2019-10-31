//
//  AppDelegate.swift
//  MyAlarm
//
//  Created by 이덕화 on 13/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //permission
        //notification
        UNUserNotificationCenter.current().requestAuthorization(options: [UNAuthorizationOptions.alert, .badge, .sound]) { (granted, error) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
                print("granted \(granted)")
            }
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let vc = AlarmModalViewController()
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let vc = AlarmModalViewController()
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
}

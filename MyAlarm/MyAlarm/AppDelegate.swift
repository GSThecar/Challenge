//
//  AppDelegate.swift
//  MyAlarm
//
//  Created by 이덕화 on 13/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import UserNotifications
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
        
        setUpWindow()
        
        return true
    }
    
    private func setUpWindow() {
        window = UIWindow()
        window?.rootViewController = TabBarController(with: TabBarPresenter())
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let wakeUpViewController = WakeUpViewController()
        wakeUpViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(wakeUpViewController, animated: true, completion: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let wakeUpViewController = WakeUpViewController()
        wakeUpViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(wakeUpViewController, animated: true, completion: nil)
    }
    
}

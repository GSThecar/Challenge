//
//  CommonViewController.swift
//  Alarm
//
//  Created by 이덕화 on 23/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    var tokens = [NSObjectProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func addObserver(name: Notification.Name, queue: OperationQueue = OperationQueue.main, using handler: @escaping (AlarmEntity) -> Void) {
        let token = NotificationCenter.default.addObserver(forName: name, object: nil, queue: queue, using: { noti in
            if let memo = noti.userInfo?["Alarm"] as? AlarmEntity {
                handler(memo)
            }
        })
        tokens.append(token)
    }
    
    func setupUI() {
        // Override
    }
    
    override func didReceiveMemoryWarning() {
        // print("\(self) did Receive Memory Warning")
    }
    
    deinit {
        // print("\(self) has deinitialized")
        for token in tokens {
            NotificationCenter.default.removeObserver(token)
        }
        
        print(self, #function)
    }
    
}

extension UINavigationBar {
    func transparentNavigationBar() {
        let image = UIImage()
        self.setBackgroundImage(image, for: UIBarMetrics.default)
        self.shadowImage = image
        self.isTranslucent = true
    }
}

extension UITabBar {
    func transparentTabBar() {
        let image = UIImage()
        self.backgroundImage = image
        self.shadowImage = image
        self.isTranslucent = true
    }
}

extension UIToolbar {
    func transparentToolBar() {
        let image: UIImage? = UIImage()
        self.setBackgroundImage(image, forToolbarPosition: .any, barMetrics: .default)
        self.setShadowImage(image, forToolbarPosition: .any)
        self.isTranslucent = true
    }
}

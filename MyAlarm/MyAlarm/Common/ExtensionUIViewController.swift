//
//  ExtensionUIViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/01/12.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

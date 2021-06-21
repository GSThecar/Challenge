//
//  TabBarController.swift
//  MyAlarm
//
//  Created by 이덕화 on 2021/06/21.
//  Copyright © 2021 GSTheCar. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    private let presenter: TabBarPresenter
    
    init(with presenter: TabBarPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func setUpTabs(with presenter: AlarmListPresenter) {
        viewControllers = [setUpAlarmListViewController(with: presenter)]
    }
    
    private func setUpAlarmListViewController(with presenter: AlarmListPresenter) -> UINavigationController {
        return UINavigationController(rootViewController: AlarmListViewController(with: presenter))
    }
}

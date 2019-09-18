//
//  AlarmViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 14/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController {

    
    @IBOutlet weak var alarmListTableView: UITableView!
    
    @IBOutlet weak var addAlarm: UIButton!
    
    
    @IBAction func addAlarm(_ sender: Any) {
        let view = AddAlarmView(frame: self.view.frame)
        self.view.addSubview(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = image
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tabBarController?.tabBar.backgroundImage = image
        self.tabBarController?.tabBar.shadowImage = image
        self.tabBarController?.tabBar.isTranslucent = true
        
        alarmListTableView.backgroundColor = UIColor.clear
        
        let nib = UINib(nibName: AlarmListTableViewCell.identifier, bundle: nil)
        alarmListTableView.register(nib, forCellReuseIdentifier: AlarmListTableViewCell.identifier)
        
        addAlarm.layer.cornerRadius = addAlarm.frame.height / 2
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AlarmListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListTableViewCell.identifier, for: indexPath) as! AlarmListTableViewCell
            cell.timeLabel.text = "00:00"
            return cell
        default:
            fatalError()
        }
    }
}


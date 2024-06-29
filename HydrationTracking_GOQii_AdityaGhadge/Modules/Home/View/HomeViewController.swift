//
//  HomeViewController.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.text = StringConstants.title.rawValue
        }
    }
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
            let cells = [CellConstants.setProgressCell.rawValue,
                         CellConstants.quickLogCell.rawValue
            ]
            for cell in cells {
                tblView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
            }
        }
    }
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        checkForPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: FUNCTIONS
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotificationOnSpecificTime()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
                    if didAllow {
                        self.dispatchNotificationOnSpecificTime()
                    }
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotificationOnSpecificTime() {
        let notificationCenter = UNUserNotificationCenter.current()
        let identifier = "my-morning-notification"
        let title = "Reminder!"
        let body = "Set you daily target"
        let hour = 8
        let minute = 0
        let isDaily = true
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        var dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
    func hideKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: TABLEVIEW TELEGATE & DATASOURCE FUNCTIONS
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblView.dequeueReusableCell(withIdentifier: CellConstants.setProgressCell.rawValue, for: indexPath) as! SetProgressTableViewCell
            cell.delegate = self
            cell.configureCell()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tblView.dequeueReusableCell(withIdentifier: CellConstants.quickLogCell.rawValue, for: indexPath) as! QuickLogTableViewCell
            cell.configureCell()
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 450
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

// MARK: SetProgressCellProtocol FUNCTIONS
extension HomeViewController: SetProgressCellProtocol {
    func showAlertMsg(msg: String) {
        self.showAlert(title: StringConstants.alertTitle.rawValue, message: msg)
    }
    
    func presentAlert() {
        let vc = AlertViewController.loadFromNib()
        self.navigationController?.present(vc, animated: true)
    }
}

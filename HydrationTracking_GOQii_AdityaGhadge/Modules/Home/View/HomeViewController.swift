//
//  HomeViewController.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
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
                         CellConstants.lottieCell.rawValue,
                         CellConstants.quickLogCell.rawValue
            ]
            for cell in cells {
                tblView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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
            cell.configureCell()
            return cell
        case 1:
            let cell = tblView.dequeueReusableCell(withIdentifier: CellConstants.lottieCell.rawValue, for: indexPath) as! LottieTableViewCell
            cell.configureCell()
            return cell
        case 2:
            let cell = tblView.dequeueReusableCell(withIdentifier: CellConstants.quickLogCell.rawValue, for: indexPath) as! QuickLogTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

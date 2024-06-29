//
//  AlertViewController.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 29/06/24.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    static func loadFromNib() -> AlertViewController {
        return AlertViewController(nibName: FileConstants.alertVC.rawValue, bundle: nil)
    }
    
    func setupUI() {
        alertView.layer.cornerRadius = 10
        alertTitle.text = StringConstants.milestoneAchieved.rawValue
        alertImageView.image = UIImage(named: ImageConstants.hurray.rawValue)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

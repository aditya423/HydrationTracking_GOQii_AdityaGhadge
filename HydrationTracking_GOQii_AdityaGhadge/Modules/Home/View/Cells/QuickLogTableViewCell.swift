//
//  QuickLogTableViewCell.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

class QuickLogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quickLogLbl: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var btn200: UIButton!
    @IBOutlet weak var btn500: UIButton!
    @IBOutlet weak var btn750: UIButton!
    @IBOutlet weak var btn1000: UIButton!
    @IBOutlet weak var lbl200: UILabel!
    @IBOutlet weak var lbl500: UILabel!
    @IBOutlet weak var lbl750: UILabel!
    @IBOutlet weak var lbl1000: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    var buttons: [UIButton] = []
    static var waterAmount: Float = 0.00
    static var updateSetProgressCell = NSNotification.Name(NotificationNames.updateSetProgress.rawValue)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        quickLogLbl.text = StringConstants.quickLog.rawValue
        customImageView.image = UIImage(named: ImageConstants.bottle0.rawValue)
        btn200.setImage(UIImage(named: ImageConstants.img200.rawValue), for: .normal)
        btn500.setImage(UIImage(named: ImageConstants.img500.rawValue), for: .normal)
        btn750.setImage(UIImage(named: ImageConstants.img750.rawValue), for: .normal)
        btn1000.setImage(UIImage(named: ImageConstants.img1000.rawValue), for: .normal)
        lbl200.text = StringConstants.ml200.rawValue
        lbl500.text = StringConstants.ml500.rawValue
        lbl750.text = StringConstants.ml750.rawValue
        lbl1000.text = StringConstants.ml1000.rawValue
        cancelBtn.setTitle(StringConstants.cancel.rawValue, for: .normal)
        cancelBtn.setTitleColor(UIColor.gray, for: .normal)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.layer.borderColor = UIColor.gray.cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5
        submitBtn.setTitle(StringConstants.log.rawValue, for: .normal)
        submitBtn.setTitleColor(UIColor.white, for: .normal)
        submitBtn.backgroundColor = UIColor.systemGreen
        submitBtn.layer.cornerRadius = 5
        btn200.tag = 0
        btn500.tag = 1
        btn750.tag = 2
        btn1000.tag = 3
        buttons = [btn200, btn500, btn750, btn1000]
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        for button in buttons {
            if button.tag == sender.tag {
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.black.cgColor
                button.isSelected = true
            } else {
                button.layer.borderWidth = 0
                button.isSelected = false
            }
        }
        
        switch sender.tag {
        case 0:
            customImageView.image = UIImage(named: ImageConstants.bottle200.rawValue)
        case 1:
            customImageView.image = UIImage(named: ImageConstants.bottle500.rawValue)
        case 2:
            customImageView.image = UIImage(named: ImageConstants.bottle750.rawValue)
        case 3:
            customImageView.image = UIImage(named: ImageConstants.bottle1000.rawValue)
        default:
            break
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        for button in buttons {
            button.isSelected = false
            button.layer.borderWidth = 0
        }
        customImageView.image = UIImage(named: ImageConstants.bottle0.rawValue)
        QuickLogTableViewCell.waterAmount = 0
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        if btn200.isSelected {
            QuickLogTableViewCell.waterAmount = 0.20
        } else if btn500.isSelected {
            QuickLogTableViewCell.waterAmount = 0.50
        } else if btn750.isSelected {
            QuickLogTableViewCell.waterAmount = 0.75
        } else if btn1000.isSelected {
            QuickLogTableViewCell.waterAmount = 1.00
        } else {
            QuickLogTableViewCell.waterAmount = 0
        }
        NotificationCenter.default.post(name: QuickLogTableViewCell.updateSetProgressCell, object: nil)
    }
}

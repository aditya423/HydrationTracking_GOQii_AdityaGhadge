//
//  QuickLogTableViewCell.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

class QuickLogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quickLogLbl: UILabel!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        quickLogLbl.text = StringConstants.quickLog.rawValue
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
    }
    
    @IBAction func btnAction200(_ sender: Any) {
    }
    
    @IBAction func btnAction500(_ sender: Any) {
    }
    
    @IBAction func btnAction750(_ sender: Any) {
    }
    
    @IBAction func btnAction1000(_ sender: Any) {
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
    }
}

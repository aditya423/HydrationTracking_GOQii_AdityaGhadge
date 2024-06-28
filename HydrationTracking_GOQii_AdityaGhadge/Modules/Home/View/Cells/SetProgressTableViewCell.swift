//
//  SetProgressTableViewCell.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

class SetProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var targetTf: UITextField!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var progressTf: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        targetLbl.text = StringConstants.target.rawValue
        progressLbl.text = StringConstants.progress.rawValue
        targetTf.text = "0.0"
        progressTf.text = "0.0"
        submitBtn.backgroundColor = UIColor(red: 110/255, green: 180/255, blue: 232/255, alpha: 1)
        submitBtn.setTitle(StringConstants.edit.rawValue, for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
    }
}

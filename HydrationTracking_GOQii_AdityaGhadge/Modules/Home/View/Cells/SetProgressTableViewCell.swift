//
//  SetProgressTableViewCell.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit

protocol SetProgressCellProtocol: NSObject {
    func showAlertMsg(msg: String)
    func presentAlert()
}

class SetProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var targetTf: UITextField!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var progressTf: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    var isEditingTf: Bool = false
    weak var delegate: SetProgressCellProtocol?
    var limit: LimitEntity?
    var limits: [LimitEntity]?
    private let manager = DatabaseManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        targetTf.delegate = self
        progressTf.delegate = self
        targetTf.tag = 0
        progressTf.tag = 1
        targetTf.keyboardType = .decimalPad
        progressTf.keyboardType = .decimalPad
        targetTf.isUserInteractionEnabled = false
        progressTf.isUserInteractionEnabled = false
        targetLbl.text = StringConstants.target.rawValue
        progressLbl.text = StringConstants.progress.rawValue
        submitBtn.backgroundColor = UIColor(red: 110/255, green: 180/255, blue: 232/255, alpha: 1)
        submitBtn.setTitle(StringConstants.edit.rawValue, for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.layer.cornerRadius = 5
        limits = manager.fetchLimits()
        if let limitsArr = limits {
            let limit = limitsArr.last
            targetTf.text = String(limit?.dailyTarget ?? 0)
            progressTf.text = String(limit?.dailyProgress ?? 0)
        } else {
            targetTf.text = "0.0"
            progressTf.text = "0.0"
        }
        setupToolbar()
        addNotificationObserver()
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextFields), name: QuickLogTableViewCell.updateSetProgressCell, object: nil)
    }
    
    @objc func updateTextFields() {
        if QuickLogTableViewCell.waterAmount > 0 {
            progressTf.text = String(QuickLogTableViewCell.waterAmount + (Float(progressTf.text ?? "0") ?? 0))
        }
        let dailyTarget = Float(targetTf.text ?? "0") ?? 0
        let dailyProgress = Float(progressTf.text ?? "0") ?? 0
        let limitModel = LimitModel(dailyTarget: dailyTarget, dailyProgress: dailyProgress)
        if let limit {
            limit.dailyTarget = dailyTarget
            limit.dailyProgress = dailyProgress
            manager.updateLimits(limit: limitModel, limitEntity: limit)
        } else {
            manager.addLimits(limit: limitModel)
        }
        if dailyProgress >= dailyTarget {
            delegate?.presentAlert()
        }
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        if isEditingTf {
            if (targetTf.text?.isEmpty ?? true) || (progressTf.text?.isEmpty ?? true) {
                targetTf.isUserInteractionEnabled = true
                progressTf.isUserInteractionEnabled = true
                targetTf.text = "0.0"
                progressTf.text = "0.0"
                delegate?.showAlertMsg(msg: StringConstants.emptyFields.rawValue)
            } else if (Float(targetTf.text ?? "-1") ?? -1 < 0) || (Float(progressTf.text ?? "-1") ?? -1 < 0) {
                targetTf.isUserInteractionEnabled = true
                progressTf.isUserInteractionEnabled = true
                targetTf.text = "0.0"
                progressTf.text = "0.0"
                delegate?.showAlertMsg(msg: StringConstants.invalidFields.rawValue)
            } else {
                targetTf.isUserInteractionEnabled = false
                progressTf.isUserInteractionEnabled = false
                let dailyTarget = Float(targetTf.text ?? "0") ?? 0
                let dailyProgress = Float(progressTf.text ?? "0") ?? 0
                let limitModel = LimitModel(dailyTarget: dailyTarget, dailyProgress: dailyProgress)
                if let limit {
                    limit.dailyTarget = dailyTarget
                    limit.dailyProgress = dailyProgress
                    manager.updateLimits(limit: limitModel, limitEntity: limit)
                } else {
                    manager.addLimits(limit: limitModel)
                }
                if dailyProgress >= dailyTarget {
                    delegate?.presentAlert()
                }
            }
            submitBtn.setTitle(StringConstants.edit.rawValue, for: .normal)
            isEditingTf = false
        } else {
            targetTf.isUserInteractionEnabled = true
            progressTf.isUserInteractionEnabled = true
            submitBtn.setTitle(StringConstants.submit.rawValue, for: .normal)
            isEditingTf = true
        }
    }
    
    func setupToolbar(){
        let bar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: StringConstants.done.rawValue, style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        targetTf.inputAccessoryView = bar
        progressTf.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard(){
        contentView.endEditing(true)
    }
}

extension SetProgressTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.contentView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

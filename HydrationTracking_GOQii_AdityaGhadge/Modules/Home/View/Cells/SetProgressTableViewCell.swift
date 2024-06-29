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
    
    // MARK: IBOUTLETS
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var targetTf: UITextField!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var progressTf: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    // MARK: VARIABLES
    weak var delegate: SetProgressCellProtocol?
    var limit: LimitEntity?
    var limits: [LimitEntity]?
    private let manager = DatabaseManager()
    
    // MARK: LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: FUNCTIONS
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
        if submitBtn.titleLabel?.text == StringConstants.submit.rawValue {
            targetTf.isUserInteractionEnabled = false
            progressTf.isUserInteractionEnabled = false
            submitBtn.setTitle(StringConstants.edit.rawValue, for: .normal)
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
        } else {
            targetTf.isUserInteractionEnabled = true
            progressTf.isUserInteractionEnabled = true
            submitBtn.setTitle(StringConstants.submit.rawValue, for: .normal)
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

// MARK: TEXTFIELD DELEGATE FUNCTIONS
extension SetProgressTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let number = Float(text) else {
            limits = manager.fetchLimits()
            if textField.tag == 0 {
                targetTf.text = String(limits?.last?.dailyTarget ?? 0)
            } else {
                progressTf.text = String(limits?.last?.dailyProgress ?? 0)
            }
            delegate?.showAlertMsg(msg: StringConstants.invalidFields.rawValue)
            return
        }
    }
}

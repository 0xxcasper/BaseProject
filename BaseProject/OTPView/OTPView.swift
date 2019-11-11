//
//  OTPView.swift
//  CarBro
//
//  Created by Sang on 11/8/19.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

@objc protocol OTPViewDelegate: class {
    @objc optional func isCorrectFormat(isCorrect: Bool, otpText: String?)
}

class OTPView: BaseView {
    //MARK: Outlet
    @IBOutlet weak var txf_First: BaseUITextField!
    @IBOutlet weak var txf_Second: BaseUITextField!
    @IBOutlet weak var txf_Third: BaseUITextField!
    @IBOutlet weak var txf_Fourth: BaseUITextField!
    @IBOutlet weak var txf_Fifth: BaseUITextField!
    @IBOutlet weak var txf_Sixth: BaseUITextField!
    
    weak var delegate: OTPViewDelegate?
    private var isBackToPreTextField: Bool = false
    private var textChange: String = ""

    override func firstInit() {
        setupTextField()
        NotificationCenter.default.addObserver(self, selector: #selector(goPrevious(_:)), name: NSNotification.Name(rawValue: "deletePressed"), object: nil)
    }
    
    @objc func goPrevious(_ textField: UITextField) {
        if(!isBackToPreTextField) {
            isBackToPreTextField = true
            return
        } else {
            if(txf_Second.isFirstResponder) {
                txf_First.becomeFirstResponder()
            } else if (txf_Third.isFirstResponder) {
                txf_Second.becomeFirstResponder()
            } else if (txf_Fourth.isFirstResponder) {
                txf_Third.becomeFirstResponder()
            } else if (txf_Fifth.isFirstResponder) {
                txf_Fourth.becomeFirstResponder()
            } else if (txf_Sixth.isFirstResponder) {
                txf_Fifth.becomeFirstResponder()
            }
        }
    }
}

extension OTPView: UITextFieldDelegate {
    
    func setupTextField() {
        txf_First.becomeFirstResponder()

        UITextField.appearance().tintColor = .black
        //Add delegate
        txf_First.delegate = self
        txf_Second.delegate = self
        txf_Third.delegate = self
        txf_Fourth.delegate = self
        txf_Fifth.delegate = self
        txf_Sixth.delegate = self
        //Change text Color
        txf_First.textColor = .black
        txf_Second.textColor = .black
        txf_Third.textColor = .black
        txf_Fourth.textColor = .black
        txf_Fifth.textColor = .black
        txf_Sixth.textColor = .black
        
        txf_First.font = FontsApp.regular.sizeFont(withSize: .h30)
        txf_Second.font = FontsApp.regular.sizeFont(withSize: .h30)
        txf_Third.font = FontsApp.regular.sizeFont(withSize: .h30)
        txf_Fourth.font = FontsApp.regular.sizeFont(withSize: .h30)
        txf_Fifth.font = FontsApp.regular.sizeFont(withSize: .h30)
        txf_Sixth.font = FontsApp.regular.sizeFont(withSize: .h30)

        txf_First.layer.borderColor = UIColor.white.cgColor
        txf_Second.layer.borderColor = UIColor.white.cgColor
        txf_Third.layer.borderColor = UIColor.white.cgColor
        txf_Fourth.layer.borderColor = UIColor.white.cgColor
        txf_Fifth.layer.borderColor = UIColor.white.cgColor
        txf_Sixth.layer.borderColor = UIColor.white.cgColor

        //Add action
        addActionTextField()
    }
    
    func addActionTextField() {
        txf_First.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txf_Second.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txf_Third.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txf_Fourth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txf_Fifth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txf_Sixth.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        textField.text = textChange
        if textChange.count == 1{
            switch textField{
            case txf_First:
                txf_Second.becomeFirstResponder()
            case txf_Second:
                txf_Third.becomeFirstResponder()
            case txf_Third:
                txf_Fourth.becomeFirstResponder()
            case txf_Fourth:
                txf_Fifth.becomeFirstResponder()
            case txf_Fifth:
                txf_Sixth.becomeFirstResponder()
            case txf_Sixth:
                txf_Sixth.resignFirstResponder()
            default:
                break
            }
            isBackToPreTextField = true
        }else if(isBackToPreTextField){
            switch textField{
            case txf_First:
                txf_First.becomeFirstResponder()
            case txf_Second:
                txf_First.becomeFirstResponder()
            case txf_Third:
                txf_Second.becomeFirstResponder()
            case txf_Fourth:
                txf_Third.becomeFirstResponder()
            case txf_Fifth:
                txf_Fourth.becomeFirstResponder()
            case txf_Sixth:
                txf_Fifth.becomeFirstResponder()
            default:
                break
            }
            isBackToPreTextField = false
        }
        self.delegate?.isCorrectFormat?(isCorrect: isEnable(), otpText: getAllText())
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        isBackToPreTextField = (textField.text == "")
//        guard let textFieldText = textField.text,
//            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
//                return false
//        }
//        let substringToReplace = textFieldText[rangeOfTextToReplace]
//        let count = textFieldText.count - substringToReplace.count + string.count
//        return count <= 1
        isBackToPreTextField = !(string == "")
        textChange = string
        return true
    }
    
    func getAllText() -> String {
        guard let str_First = txf_First.text, let str_Second = txf_Second.text, let str_Third = txf_Third.text, let str_Fourth = txf_Fourth.text, let str_Fifth = txf_Fifth.text, let str_Sixth = txf_Sixth.text else { return "" }
        return str_First + str_Second + str_Third + str_Fourth + str_Fifth + str_Sixth
    }
    
    func isEnable() -> Bool {
        return (txf_First.text != "" && txf_Second.text != "" && txf_Third.text != "" && txf_Fourth.text != "" && txf_Fifth.text != "" && txf_Sixth.text != "" )
    }
}

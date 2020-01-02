//
//  PopupViewApp.swift
//  CarBro
//
//  Created by iMac Flix on Jul/02/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

class PopupViewApp: BaseView {

    @IBOutlet weak var imgPopup: UIImageView!
    @IBOutlet weak var viewBackground: BaseViewApp!
    @IBOutlet weak var btnOnlyOne: BaseUIButton!
    @IBOutlet weak var heightImagePopup: NSLayoutConstraint!
    @IBOutlet weak var viewContainsTwoButton: UIView!
    @IBOutlet weak var viewLine: BaseViewApp!
    @IBOutlet weak var lbTitle: BaseUILabel!
    @IBOutlet weak var lbDetail: BaseUILabel!
    @IBOutlet weak var btLeft: BaseUIButton!
    @IBOutlet weak var btRight: BaseUIButton!
    @IBOutlet weak var viewContain: BaseViewApp!
    var okHandler: (() -> Void)!
    var cancelHandler: (() -> Void)!
    
    override func firstInit() {
        viewBackground.setBackgroundView(color: UIColor.colorText_Title, alpha: 0.8)
        viewLine.setBackgroundView(color: UIColor.colorLine)
        btRight.setTitleColor(UIColor.colorRedNotify, for: .normal)
        lbTitle.textColor = UIColor.colorText_Title
        lbDetail.setTitleApp(size: .h18)
        lbDetail.textColor = UIColor.colorText_detail
        lbDetail.setTitleApp(size: .h14)
        viewContain.cornerRadiusWith(radius:4)
    }
    
    func setupPopup(_ isShowOnlyBtnOne: Bool = true, isHideImage: Bool = true, title: String = kEmptyString, detail: String, urlImage: String = kEmptyString, textBtnLeft: String = text_ignore, textBtnRight: String = kEmptyString, textBtnOnly: String = text_close, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil){
        okHandler = okAction
        cancelHandler = cancelAction
        viewContainsTwoButton.isHidden = isShowOnlyBtnOne
        btnOnlyOne.isHidden = !isShowOnlyBtnOne
        heightImagePopup.constant = isHideImage ? 0 : 198
        lbTitle.text = title
        lbDetail.text = detail
        btRight.setTitle(textBtnRight, for: .normal)
        btLeft.setTitle(textBtnLeft, for: .normal)
        btnOnlyOne.setTitle(textBtnOnly, for: .normal)
    }

    @IBAction func actTapLeft(_ sender: Any) {
        self.removeFromSuperview()
        cancelHandler()
    }
    @IBAction func actTapRight(_ sender: Any) {
        self.removeFromSuperview()
        okHandler()
    }
    @IBAction func actTapOnlyBtn(_ sender: Any) {
        self.removeFromSuperview()
        cancelHandler()
    }
    @IBAction func actCloseView(_ sender: Any) {
//        self.removeFromSuperview()
    }
}

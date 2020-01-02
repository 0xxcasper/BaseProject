//
//  BaseModel.swift
//  ITP
//
//  Created by iMac Flix on May/29/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

//
//  Utilities.swift
//  Car Eco Project
//
//  Created by LeTrung on 9/1/16.
//  Copyright © 2016 Flix.com.vn. All rights reserved.
//


//MARK: Animation

class func animationShowView(view : UIView, finish: ((Bool) -> Void)? = nil) {
    view.alpha = 0
    view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    UIView.animate(withDuration: 0.3, animations: {
        view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        view.alpha = 1
    }, completion: finish)
}

class func animationRemoveView(view : UIView, finish: ((Bool) -> Void)? = nil){
    UIView.animate(withDuration: 0.3, animations: {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0
    }, completion: finish)
}

class func removeChildViewController(vc : UIViewController){
    vc.willMove(toParent: nil)
    vc.view.removeFromSuperview()
    vc.removeFromParent()
}

private func showPopup(_ item: PointLog) {
    DispatchQueue.main.async {
        let popup = HistoryPointViewPopup()
        popup.setupData(self.setupData(item))
        popup.frame = UIScreen.main.bounds
        UIApplication.shared.keyWindow?.addSubview(popup)
        popup.show(animation: true)
    }
}

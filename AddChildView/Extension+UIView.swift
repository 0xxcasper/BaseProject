//
//  Extension+UIView.swift
//  ITP
//
//  Created by iMac Flix on Jun/27/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit
import MessageKit

extension UIView {
    func dropShadowView(scale: Bool = true, borderColor: UIColor = UIColor(red:0.29, green:0.31, blue:0.33, alpha:0.3), borderWidth: CGFloat = 0, cornerRadius: CGFloat = 0, backgroundColor: UIColor = .white, shadowColor: UIColor = UIColor(red:0.29, green:0.31, blue:0.33, alpha:0.3), shadowOpacity: Float = 0, shadowOffset: CGSize = CGSize(width: 0, height: 3), shadowRadius: CGFloat = 6){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = backgroundColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    /**
     *
     */
    func roundView(){
        layer.cornerRadius = bounds.width/2
    }
    func cornerRadiusWith(radius: CGFloat){
        layer.cornerRadius = radius
        
    }
    
    func show(animation: Bool) {
        weak var weakself = self
        self.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        self.alpha = 1
        if animation {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                weakself?.alpha = 1.0
                weakself?.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        else {
            weakself?.alpha = 1.0
            weakself?.transform = CGAffineTransform.identity
        }
    }
    /**
     *
     */
    func dismiss(animation: Bool) {
        weak var weakself = self
        if animation {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                weakself?.alpha = 0
                weakself?.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
            }, completion: { (bool) in
                weakself?.removeFromSuperview()
            })
        }
        else {
            weakself?.alpha = 0
            weakself?.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
            weakself?.removeFromSuperview()
        }
    }
    func showConfirmMessage(_ isShowOnlyBtnOne: Bool = true, isHideImage: Bool = true, title: String = kEmptyString, detail: String, urlImage: String = kEmptyString, textBtnLeft: String = text_ignore, textBtnRight: String = kEmptyString, textBtnOnly: String = text_close, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil)  {
        DispatchQueue.main.async {
            let message = PopupViewApp()
            message.frame = self.bounds
            self.addSubview(message)
            message.setupPopup(isShowOnlyBtnOne, isHideImage: isHideImage, title: title, detail: detail, urlImage: urlImage, textBtnLeft: textBtnLeft, textBtnRight: textBtnRight, textBtnOnly: textBtnOnly, okAction: {
                if okAction != nil{
                    okAction!()
                }
            }, cancelAction: {
                if cancelAction != nil{
                    cancelAction!()
                }
            })
            message.show(animation: true)
        }
    }
    
    func getAvatarFor(sender: Sender) -> Avatar {
        let firstName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")"
        return Avatar(image: nil, initials: initials)
    }
    
    func animationView(_ isLeftToRight: Bool){
        weak var weakself = self
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            weakself?.alpha = 0
            weakself?.frame = CGRect(x: -(weakself?.frame.size.width)!, y: (weakself?.frame.origin.y)!, width: (weakself?.frame.size.width)!, height: (weakself?.frame.size.height)!)
        }, completion: { (bool) in
            weakself?.frame = CGRect(x: 0, y: (weakself?.frame.origin.y)!, width: (weakself?.frame.size.width)!, height: (weakself?.frame.size.height)!)
        })
        
    }
    
    func rotateView(view: UIView, duration: Double = 1) {
        if view.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = -Float(.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    func animationShowView(finish: ((Bool) -> Void)? = nil) {
        self.transform = CGAffineTransform(translationX: -self.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: finish)
    }
    
    func animationRemoveView(finish: ((Bool) -> Void)? = nil){
        self.transform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: -self.frame.size.width, y: 0)
        }, completion: finish)
    }
    
    func zoomInSelectControl() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }
    }
    
    func zoomOutUnSelectControl() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    func addViewImage(realSize : CGRect, imv: BaseUIImageView) -> UIView{
        let view = UIView(frame: realSize)
        view.tag = tagDetailView
        imv.translatesAutoresizingMaskIntoConstraints = false
        let leftImv = NSLayoutConstraint(item: imv, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let rightImv = NSLayoutConstraint(item: imv, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let topImv = NSLayoutConstraint(item: imv, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let botImv = NSLayoutConstraint(item: imv, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addSubview(imv)
        NSLayoutConstraint.activate([leftImv,rightImv,topImv,botImv])
        return view
    }
    
}

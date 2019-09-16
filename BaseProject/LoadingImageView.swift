//
//  LoadingImageView.swift
//  TMD
//
//  Created by iMac Flix on Jun/24/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

class LoadingImageView: BaseView {

    @IBOutlet weak var lbLoadingImage: BaseUILabel!
    @IBOutlet weak var img_loading: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loading(){
        lbLoadingImage.text = kLoadingImage
        lbLoadingImage.setUIWith(color: UIColor.colorText_detail, font: FontsApp.regular.sizeFont(withSize: .h12))
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(rotationLoading), userInfo: nil, repeats: true)
    }
    
    @objc func rotationLoading(){
        self.rotateView(view: self.img_loading)
    }

}
 

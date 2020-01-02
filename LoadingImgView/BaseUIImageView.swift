//
//  BaseUIImageView.swift
//  CarBro
//
//  Created by iMac Flix on Jul/17/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

class BaseUIImageView: UIImageView {
    var viewLoading = LoadingImageView()
    var imageDefault: UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async{
            self.addSubview(self.viewLoading)
            self.viewLoading.translatesAutoresizingMaskIntoConstraints = false
            self.viewLoading.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.viewLoading.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.viewLoading.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.viewLoading.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.viewLoading.loading()
        }
    }
    
    func setImageDefaults(){
        DispatchQueue.main.async{
            self.viewLoading.removeFromSuperview()
            self.image = Utilities.resizeImage(image: #imageLiteral(resourceName: "ic_updating"), targetSize: self.bounds.size)
            self.contentMode = .scaleAspectFit
        }
    }
    
    func setImageAvatarDefaults() {
        DispatchQueue.main.async{
            self.viewLoading.removeFromSuperview()
            self.image = #imageLiteral(resourceName: "ic_userBlack")
        }
    }
    
    func setImage(url: String? = nil){
        guard let urlStr = url else{
            self.setImageDefaults()
            return
        }
        self.sd_setImage(with: URL(string: urlStr), completed: { [weak self] (image, error, type, url) in
            DispatchQueue.main.async{
                self?.viewLoading.removeFromSuperview()
                guard let _ = error else{
                    return
                }
                self?.image = Utilities.resizeImage(image: #imageLiteral(resourceName: "ic_updating"), targetSize: self!.bounds.size)
            }
        })
    }
}



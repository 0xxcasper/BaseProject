//
//  ServiceScheduleModel.swift
//  CarBro
//
//  Created by iMac Flix on Aug/02/2019.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

import UIKit

class ServiceScheduleModel: BaseModel {

    @objc dynamic var typecell = ""
    @objc dynamic var idItem = ""
    @objc dynamic var placeholder = ""
    @objc dynamic var text = ""
    @objc dynamic var icon = ""
    @objc dynamic var keyboardType = 0
    @objc dynamic var typeKeyboard = UIKeyboardType.default
  
    class func getDataScheduleService(_ nameFile: String = "ScheduleService") -> [ServiceScheduleModel]{
        var outputs = [ServiceScheduleModel]()
        let arrDic = dataFromFile.getDataFromFile(with: nameFile)

        arrDic.forEach { (dic) in
            let item = ServiceScheduleModel(dictionary: dic)
            if item.keyboardType == 0{
                item.typeKeyboard = .default
            }
            if item.keyboardType == 1{
                item.typeKeyboard = .emailAddress
            }
            if item.keyboardType == 2{
                item.typeKeyboard = .numberPad
            }
            if item.keyboardType == 3{
                item.typeKeyboard = .decimalPad
            }
            outputs.append(item)
        }
        return outputs
    }
    
}

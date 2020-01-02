//
//  ContainerHistoryPoint.swift
//  CarBro
//
//  Created by Sang on 12/11/19.
//  Copyright © 2019 ITP Vietnam. All rights reserved.
//

//->convertDateToString

class func convertDateToString(_ date: Date, format: String)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    return dateFormatter.string(from: date)
}

//->ConvertStringToDate Pass format

class func convertStringToDate(_ strDate : String, format : String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    let date = dateFormatter.date(from: strDate)
    return date!
}

//->ConvertStringToDate no Format

func converStrToDate(isDash: Bool = true) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = isDash ? "dd-MM-yyyy" : "dd/MM/yyyy"
    return dateFormatter.date(from: self)!
}

extension Date
{
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }

}

//So sanh 2 date
func filterData() -> [PointLog]? {
    var _pointLogs: [PointLog] = []
    if(minDate == nil || maxDate == nil || pointLogs.count == 0) { return nil }
    pointLogs.forEach { (item) in
        if(item.createdAt != nil) {
            let itemDate = splitString(item.createdAt)
            if itemDate >= minDate!  && itemDate <= maxDate! {
                _pointLogs.append(item)
            }
        }
    }
    return _pointLogs
}

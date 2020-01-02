//
//  Utilities.swift
//  Car Eco Project
//
//  Created by LeTrung on 9/1/16.
//  Copyright © 2016 Flix.com.vn. All rights reserved.
//

import Foundation
import MRProgress
import SafariServices
import SystemConfiguration
import AVFoundation

let TAG_DIM_VIEW        =   567
let TAG_INDICATOR       =   456

class Utilities: NSObject {
    func openFacebook(_ linkFace: String) {
        guard let url = URL(string: linkFace) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:]) { (rults) in
                    
                }
            }else{
                UIApplication.shared.open(URL(string: linkFace)!, options: [:]) { (rults) in
                }
            }
        } else {
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.openURL(url)
            }else{
                UIApplication.shared.openURL(URL(string: linkFace)!)
            }
        }
    }

    class func openNotificationLink(notificationModel : NotificationModel, failed: @escaping (String) -> Void) {
        var linkUrl : URL! = nil

        if notificationModel.typeExtra != nil {
            if notificationModel.typeExtra == key_youtube {
                if let link = notificationModel.text {
                    if link.contains("=") {
                        let linkId = notificationModel.text.components(separatedBy: "=")[1]
                        guard let url = URL(string:"youtube://\(linkId)") else {
                            failed("Đường dẫn không khả dụng")
                            return
                        }
                        linkUrl = url
                    } else {
                        linkUrl = URL(string: notificationModel.text)!
                    }
                } else {
                    linkUrl = URL(string: notificationModel.text)!
                }
            } else if notificationModel.typeExtra == key_facebook {
                linkUrl = URL(string:"facewebmodal/f?href=" + notificationModel.text)!
            } else {
                linkUrl = URL(string: notificationModel.text)!
            }

            if linkUrl != nil {
                if !UIApplication.shared.canOpenURL(linkUrl)  {
                    if notificationModel.text != nil {
                        if !(notificationModel.text.starts(with: httpStr) && !notificationModel.text.starts(with: "https://")) {
                            linkUrl = URL(string: httpStr + notificationModel.text)!
                        } else {
                            linkUrl = URL(string: notificationModel.text)!
                        }
                    }
                }
            }
        } else {
            linkUrl = URL(string: notificationModel.text)!
        }

        if linkUrl != nil {
            self.openWebBrowser(url : linkUrl)
        }
    }

    class func openWebBrowser(url : URL) {
        // iOS 10 support
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    //MARK: String
    class func checkStringIsEmpty(_ str : String) -> Bool {
        let strimmer : String = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if strimmer.isEmpty {
            return true
        }
        return false
    }
    
    class func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func checkStringIsHaveSpecialChar(_ text: String) -> Bool{
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ âấầẩẫậÂẤẦẨẪẬáàảãạÁÀẢÃẠăắằẳẵặĂẮẰẲẴẶêếềểễệÊẾỀỂỄỆéèẻẽẹÉÈẺẼẸíìỉĩịÍÌỈĨỊôốồổỗộÔỐỒỔỖỘơớờởỡợƠỚỜỞỠỢưứừửữựƯỨỪỬỮỰýỳỷỹỵÝỲỶỸỴĐđóòỏõọÓÒỎÕỌúùủũụÚÙỦŨỤ0123456789")
        return text.rangeOfCharacter(from: characterset.inverted) != nil
    }
    
    class func checkStringHaveAlphabet(_ text: String) -> Bool {
        for chr in text.uppercased() {
            if (chr >= "A" && chr <= "Z") {
                return true
            }
        }
        return false
    }
    
    class func checkStringIsHaveNumberChar(_ text : String) -> Bool{
        let phone = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: kEmptyString)
        if phone == kEmptyString {
            ///have number
            return false
        }else {
            ///Don't have number
            return true
        }
    }

    class func validPassword(pass : String) -> Bool {

        do {
            try pass.validatePassword()
            print("valid password action")
            return true
        } catch let error as ValidatePasswordError {
            switch error {
            case .needsAtLeastEightCharacters:
                print("need 8 character")
                return false
            case .needsAtLeastOneLetter:
                debugPrint("Needs At Least One Letter")    // "NeedsAtLeastOneLetter action\n"
                return false
            case .needsAtLeastOneDecimalDigit:
                debugPrint("Needs At Least One Number action")
                return false
            }
        }catch let error as NSError {
            print(error.code)
            print(error.domain)
            return false
        }
    }
    
    class func getDeviceInfo() -> Dictionary<String,AnyObject>{
        var deviceInfo : Dictionary<String,AnyObject> = [:]
        
        deviceInfo.updateValue(UIDevice.current.name as AnyObject, forKey: key_device_name)
        deviceInfo.updateValue(UIDevice.current.model as AnyObject, forKey: key_device_model)
        deviceInfo.updateValue(UIDevice.current.systemName as AnyObject, forKey: key_device_type)
        deviceInfo.updateValue(UIDevice.current.systemVersion as AnyObject, forKey: key_device_version)
        deviceInfo.updateValue(UIDevice.current.identifierForVendor!.uuidString as AnyObject, forKey: key_device_UDID)
        deviceInfo.updateValue(self.getWiFiAddress() as AnyObject, forKey: key_ip)
        
        return deviceInfo
    }
    
    class func validUrl (urlString: String?) -> Bool {
        //Check for nil
        if var urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    class func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    if let name = String(validatingUTF8: (interface?.ifa_name)!) , name == "en0" {
                        
                        // Convert interface address to a human readable string:
                        var addr = interface?.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(&addr!, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    class func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func getMarkerImage(selectStation : String) -> UIImageView{
        var image : UIImageView = UIImageView()
        switch selectStation {
        case google_type_parking:
            image = UIImageView(image: UIImage(named: "ic_parking_on"))
        case google_type_gas:
            image = UIImageView(image: UIImage(named: "ic_gas_on"))
        case google_type_carRepair:
            image = UIImageView(image: UIImage(named: "ic_sos_on"))
        case google_type_atm :
            image = UIImageView(image: UIImage(named: "ic_atm_on"))
        case google_type_hospital :
            image = UIImageView(image: UIImage(named: "ic_hospital_on"))
        default:break
        }
        return image
    }
    
    class func convertDistanceToString(distance : Float) -> String{
        //distance is meters
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if distance < 1000 {
            return String(Int(distance)) + " m"
        }else{
            let tmpdistance = NSNumber(value: Float(distance/1000))
            return formatter.string(from: tmpdistance)! + " km"
        }
    }
    
    class func priceFormatShowing(price : NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: price)!.replacingOccurrences(of: ",", with: ".") 
    }
    
    class func convertPriceToNumber(str : String) -> NSNumber{
        let tmpStr = str.replacingOccurrences(of: ".", with: kEmptyString).replacingOccurrences(of: " ", with: kEmptyString)
        return NSNumber(value: Int64(tmpStr)!)
    }
    
    //MARK: behaviorControl
    
    class func disableControl(control : UIView) {
        #if TMD || TBN || ITP
            control.isUserInteractionEnabled = false
            control.alpha = 0.5
        #elseif TTX || TCD
            if control is UIButton {
                (control as! UIButton).setTitleColor(UIColor().HexToColor(color_black_text, alpha: 1.0), for: .normal)
                (control as! UIButton).backgroundColor = UIColor().HexToColor(color_gray_light, alpha: 1.0)
                control.isUserInteractionEnabled = false
                control.alpha = 0.5
            }else{
                control.isUserInteractionEnabled = false
                control.alpha = 0.5
            }
        #endif
    }
    
    class func enableControl(control : UIView) {
        #if TMD || TBN || ITP
            control.isUserInteractionEnabled = true
            control.alpha = 1.0
        #elseif TTX || TCD
            if control is UIButton {
                (control as! UIButton).setTitleColor(UIColor.white, for: .normal)
                (control as! UIButton).backgroundColor = UIColor().HexToColor(color_gray_bold, alpha: 1.0)
                control.isUserInteractionEnabled = true
                control.alpha = 1.0
            }else{
                control.isUserInteractionEnabled = true
                control.alpha = 1.0
            }
        #endif
    }
    
    class func disableControlOld(control : UIView) {
        control.isUserInteractionEnabled = false
        control.alpha = 0.5
    }
    
    class func enableControlOld(control : UIView) {
        control.isUserInteractionEnabled = true
        control.alpha = 1.0
    }
    
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
    
    //MARK: Indicator
    
    class func showHub(title: String = kEmptyString){
        DispatchQueue.main.async{
            if Utilities.isInternetAvailable() {
                let window : UIWindow = UIApplication.shared.keyWindow!
                let dimView: UIView = UIView()
                dimView.frame = window.frame
                dimView.backgroundColor = UIColor.black
                dimView.alpha = 0.4
                dimView.tag = TAG_DIM_VIEW
                window.addSubview(dimView)
                window.bringSubviewToFront(dimView)

                let indicator: MRActivityIndicatorView = MRActivityIndicatorView()
                indicator.frame = CGRect(x: (window.frame.size.width - 50)/2, y: (window.frame.size.height - 50)/2, width: 50, height: 50)
                indicator.tintColor = UIColor().HexToColor(color_main_red, alpha: 1)
                window.addSubview(indicator)
                window.bringSubviewToFront(indicator)
                indicator.tag = TAG_INDICATOR
                indicator.startAnimating()
            } else {
                removeHub()
            }
            
        }
    }
    
    class func removeHub() {
        DispatchQueue.main.async{
            let window : UIWindow = UIApplication.shared.keyWindow!
            let dimview = window.viewWithTag(TAG_DIM_VIEW)
            dimview?.removeFromSuperview()
            let indicator = window.viewWithTag(TAG_INDICATOR)
            indicator?.removeFromSuperview()
        }
    }
    
    class func getMarkerIcon(type : String) -> UIImage{
        var image : UIImage?
        switch type {
        case google_type_parking:
            image = UIImage(named: "ic_parking")!
        case google_type_gas:
            image = UIImage(named: "ic_gas")!
        case google_type_carRepair:
            image = UIImage(named: "ic_rescue")!
        case google_type_atm:
            image = UIImage(named: "ic_atm")!
        case google_type_hospital:
            image = UIImage(named: "ic_hospital")!
        default:
            break
        }
        return image!
        
    }
    
    class func getAddressInfo(place : CLPlacemark) -> String {
        var strAddress = kEmptyString
        
        if let name = place.name{
            strAddress += String(name)
        }
        if let subArea = place.subAdministrativeArea{
            strAddress += ", " + String(subArea)
        }
        if let city = place.locality{
            strAddress += ", " + String(city)
        }else if let subCity = place.subLocality {
            strAddress += ", " + String(subCity)
        }
        
        return strAddress
    }
    
    //MARK: button
    
    class func updateImageCenterButton(btn : UIButton) {
        let spacing: CGFloat = 10.0
        let imageSize: CGSize = btn.imageView!.image!.size
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: btn.titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: btn.titleLabel!.font])
        btn.imageEdgeInsets = UIEdgeInsets.init (top: 0 - titleSize.height, left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        btn.contentEdgeInsets = UIEdgeInsets.init(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        
    }
    
    //MARK: PhoneCall
    
    class func makePhoneCall(number : String) {
        if UIApplication.shared.canOpenURL(URL(string: "tel://")!) {
            let url = URL(string: "tel://\(number.removeAllWhitespaces())")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
                // Fallback on earlier versions
            }
        }
    }
    
    class func makeBrowerInApp(slug : String, vc : UIViewController) {
        let strURL = base_browser + slug + "/n"
        if UIApplication.shared.canOpenURL(URL(string: strURL)!) {
            var safariController: SFSafariViewController?
            if #available(iOS 11.0, *) {
                safariController = SFSafariViewController(url: URL(string: strURL)!)
            } else {
                safariController = SFSafariViewController(url: URL(string: strURL)!, entersReaderIfAvailable: true)
            }
            vc.present(safariController!, animated: true, completion: nil)
        }
    }
    
    //MARK: Date
    
    class func convertDateToString(_ date: Date, format: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    
    class func convertStringToDate(_ strDate : String, format : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.date(from: strDate)
        
        return date!
    }
    
    //MARK: ResizeImage
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK:Marker
    
    class func addMarker(position : CLLocationCoordinate2D , mapView : GMSMapView, icon : UIImage, isMain : Bool, title : String) {
        let mainMarker : GMSMarker = GMSMarker()
        
        mainMarker.title = title
        mainMarker.position = position
        
        mainMarker.iconView = UIImageView(image: icon)
        mainMarker.iconView?.contentMode = UIView.ContentMode.center
        
        mainMarker.map = mapView
        if isMain {
            mapView.animate(with: .setCamera(GMSCameraPosition(target: mainMarker.position, zoom: 15.0, bearing: 0, viewingAngle: 0)))
        }
    }
    
    class func formatFileSize(bytes: Double) -> String {
        guard bytes > 0 else {
            return "0 bytes"
        }
        
        // Adapted from http://stackoverflow.com/a/18650828
        let suffixes = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        let k: Double = 1000
        let i = floor(log(bytes) / log(k))
        
        // Format number with thousands separator and everything below 1 GB with no decimal places.
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = i < 3 ? 0 : 1
        numberFormatter.numberStyle = .decimal
        
        let numberString = numberFormatter.string(from: NSNumber(value: bytes / pow(k, i))) ?? "Unknown"
        let suffix = suffixes[Int(i)]
        return "\(numberString) \(suffix)"
    }
    
    class func createAttachmentDirectory() -> String {
        let attachmentDirectory = getAttachmentDirectory()
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: attachmentDirectory) {
            try! fileManager.createDirectory(atPath: attachmentDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        return attachmentDirectory
    }
    
    class func deleteAttachmentDirectory() {
        let attachmentDirectory = getAttachmentDirectory()
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: attachmentDirectory) {
            try! fileManager.removeItem(atPath: attachmentDirectory)
        }
    }
    
    class func getAttachmentDirectory() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(HEADER)
    }
    
    class func saveAttachment(attachmentData : Data, attachmentName : String) {
        let attachmentDirectory: String = createAttachmentDirectory()
        let attachmentFile: String = (attachmentDirectory as NSString).appendingPathComponent(attachmentName)
        
        let fileManager = FileManager.default
        fileManager.createFile(atPath: attachmentFile, contents: attachmentData, attributes: nil)
    }
    
    class func getAttachment(attachmentName : String) -> String {
        let attachmentDirectory: String = createAttachmentDirectory()
        let attachmentFile: String = (attachmentDirectory as NSString).appendingPathComponent(attachmentName)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: attachmentFile) {
            return attachmentFile
        } else {
            return kEmptyString
        }
    }
    
    class func mediaPreviewUIImage(moviePath: URL) -> UIImage? {
        let asset = AVURLAsset(url: moviePath)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
        if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
            return UIImage(cgImage: imageRef)
        } else {
            return nil
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

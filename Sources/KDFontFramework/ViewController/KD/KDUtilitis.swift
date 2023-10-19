//
//  KDUtilitis.swift
//  Alhendin
//
//  Created by Deepak Arora on 10/01/18.
//  Copyright © 2018 Deepak Arora. All rights reserved.
//

import UIKit
//import SwiftValidator

enum VALUETYPE {
    case string
    case array
    case dictionary
    case any
    case dic_array
}
class KDUtilitis: NSObject {
    var is_ipad = Bool()
    static let sharedInstance = KDUtilitis()
    var arrElements                 = [AnyObject]()

    override init() {
    }
    
    
    func setupIconColour(imgvw: UIImageView, colour:UIColor) -> Void {
        if imgvw == nil{
            
        }else{
            if imgvw.image == nil{
                
            }else{
                
                let templateImage = imgvw.image?.withRenderingMode(.alwaysTemplate)
                imgvw.image = templateImage
                imgvw.tintColor = colour
            }
        }
    }
    func setupIconColour(imgvw: UIImageView, colour:UIColor, lbl: UILabel) -> Void {
        if imgvw == nil{
            
        }else{
            if imgvw.image == nil{
                
            }else{
                let tintedImage = UIImage.iconTinted(imgvw.image!)(color: colour)
                imgvw.image = tintedImage
                lbl.textColor  = colour
            }
        }
    }
    
    func is_non_optional(str: String) -> Bool {
        if str != nil {
            return false
        }else{
            if self.checkForStringWhiteSpace(chek_string: str){
                return true
                
            }else{
                return false
            }
        }
    }
    func checkForStringWhiteSpace(chek_string: String) -> Bool{
        var array = [AnyHashable]()
        let ch_count = chek_string.count
        if let count = ch_count as? Int{
            for i in 0..<count {
                let ch = (chek_string as NSString?)?.substring(with: NSRange(location: i, length: 1))
                if let aCh = ch {
                    array.append(aCh)
                }
            }
        }
        var final_arr = [AnyHashable]()
        for i in 0..<array.count {
            if let element = array[i] as? String{
                if (element == " ") || (element == "\n") {
                    final_arr.append("white_space")
                } else {
                    final_arr.append("charecter")
                }
            }
        }
        if final_arr.contains("charecter") {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    
    
    func arrAllElement(_ View: UIView?) -> [AnyHashable]? {
        arrElements = [AnyObject]()
        self.listSubviewsOf(View)
        return arrElements as? [AnyHashable]
    }
    
    func listSubviewsOf(_ view: UIView?) {
        let subviews = view?.subviews
        //        if subviews?.count == 0 || subviews == nil{
        //            return
        //        }
        if let count = subviews?.count{
            if subviews?.count == 0{
                return}
            
            if count > 0{
                for subview: UIView? in subviews! {
                    // Do what you want to do with the subview
                    if (subview is UILabel) {
                        let lbl = subview as? UILabel
                        if let aLbl = lbl {
                            arrElements.append(aLbl)
                        }
                    } else if (subview is UITextView) {
                        let textVw = subview as? UITextView
                        if let aVw = textVw {
                            arrElements.append(aVw)
                        }
                    } else if (subview is UITextField) {
                        let text = subview as? UITextField
                        if let aText = text {
                            arrElements.append(aText)
                        }
                    } else if (subview is UIButton) {
                        let btn = subview as? UIButton
                        if let aBtn = btn {
                            arrElements.append(aBtn)
                        }
                    } else if (subview is UIImageView) {
                        let img = subview as? UIImageView
                        if let anImg = img {
                            arrElements.append(anImg)
                        }
                    }
                    else if (subview is UIScrollView) {
                        let scrl = subview as? UIScrollView
                        if let scrlvw = scrl {
                            arrElements.append(scrlvw)
                        }
                    } else if (subview is UIView) {
                        let vwe = subview
                        if let vwew = vwe {
                            arrElements.append(vwew)
                        }
                    }
                    if subview == nil{
                        break
                    }else{
                        listSubviewsOf(subview)
                    }
                }
            }
        }
    }
    
    func convertIntToString(int: Int) -> String {
        let x : Int = int
        let xNSNumber = x as NSNumber
        let xString : String = xNSNumber.stringValue
        return xString
    }
    
    func getValue(value: Any!, type: VALUETYPE) -> Any {
        if value is [String]{
            let arr = value as! [String]
            if arr.count > 0{
                switch type {
                case .string:
                    let name : String! = (arr[0] )
                    if let id = name{
                        if KDUtilitis.sharedInstance.is_non_optional(str: id){
                            return id
                        }
                    }
                case .array:
                    var arr_comment = [String] ()
                    for indx in 0..<arr.count {
                        let name : String! = (arr[indx] )
                        if let id = name{
                            if KDUtilitis.sharedInstance.is_non_optional(str: id){
                                arr_comment.append(id)
                            }
                        }
                    }
                    return arr_comment
                default: break
                }
            }
        } else if value is [AnyObject]{
            let arr = value as! [AnyObject]
            if arr.count > 0{
                switch type {
                case .string:
                    let obj = arr[0]
                    if obj is [String: AnyObject]{
                        let dic = obj as! [String: AnyObject]
                        let keys = Array(dic.keys)
                        for indx in 0..<keys.count{
                            if keys[indx] == "number" || keys[indx] == "text"{
                                if let id = dic[keys[indx]]{
                                        return id
                                }
                            }
                        }
                    }
                case .array:
                    var arr_comment = [String] ()
                    for indx in 0..<arr.count {
                        
                        let obj = arr[indx]
                        if obj is [String: AnyObject]{
                            let dic = obj as! [String: AnyObject]
                            let keys = Array(dic.keys)
                            for indx in 0..<keys.count{
                                if keys[indx] == "number" || keys[indx] == "text"{
                                    if let id = dic[keys[indx]]{
                                        if KDUtilitis.sharedInstance.is_non_optional(str: id as! String){
                                            arr_comment.append(id as! String)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return arr_comment
                default: break
                }
            }
        } else if value is String{
            let name : String! = (value as! String)
            if let id = name{
                if KDUtilitis.sharedInstance.is_non_optional(str: id){
                    return id
                }
            }
        }
        return ""
    }
    func getType(value: Any!) -> Int {
        if value is [String]{
            return 1
        } else if value is [AnyObject]{
            return 2
        }
        return 0
    }
    
}
extension UIImage{
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> UIImage? {
        return UIImage(data: jpegData(compressionQuality: jpegQuality.rawValue)!)!
    }
    
    func iconTinted(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        guard let cgImage = cgImage else { return self }
        
        // flip the image
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)
        
        // multiply blend mode
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        
        // create uiimage
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        
        return newImage
        
    }

    func resizeImageWith(newSize: CGSize) -> UIImage {
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    func resizeImage(scaledToFill size: CGSize) -> UIImage? {
            let scale: CGFloat = max(size.width / (self.size.width ), size.height / (self.size.height ?? 0.0))
        let width: CGFloat = (self.size.width ?? 0.0) * scale
            let height: CGFloat = (self.size.height ?? 0.0) * scale
        let imageRect = CGRect(x: (size.width - width) / 2.0, y: (size.height - height) / 2.0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
            self.draw(in: imageRect)
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

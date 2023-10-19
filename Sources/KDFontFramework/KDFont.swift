//
//  KDFont.swift
//
//  Created by Krishnarjun Dutta on 30/07/18.
//  Copyright © 2018 Krishnarjun Dutta. All rights reserved.
//  Update by © Krishnarjun Dutta on 14/02/23.

import UIKit

public class KDFont: NSObject {
    var arrElements              = [AnyObject]()
    public static let shared = KDFont()
    public var fontNameRegular : String = ""
    public var fontNameMedium : String = ""
    public var fontNameBold : String = ""

    
    //MARK: Size + Type ----> IF 203 THen Size 20
    //MARK: Set Custom Font Type: IF 0 = REGULAR, 1 = SEMIBOLD, 2 = BOLD
    //========================

    func setCustomFont(ofSize:CGFloat, types:Int) -> UIFont {
        let size = CGFloat(0)
        if types == 0 {
          return UIFont(name: fontNameRegular, size: ofSize + size) ?? UIFont.systemFont(ofSize: 0)
        }else if types == 1{
          return UIFont(name: fontNameMedium, size: ofSize + size) ?? UIFont.systemFont(ofSize: 0)
        }else if types == 2{
          return UIFont(name: fontNameBold, size: ofSize + size) ?? UIFont.boldSystemFont(ofSize: 0)
        }else if types == 3{
          return UIFont(name: fontNameBold, size: ofSize + size) ?? UIFont.boldSystemFont(ofSize: 0)
        }else{
          return UIFont(name: fontNameRegular, size: ofSize) ?? UIFont.systemFont(ofSize: 0)
        }
      }
 
    //MARK: Colour For Icon
    //========================

    var colour500 : UIColor = UIColor(named: "iconColor #48 37 118") ?? .red
    var colour501 : UIColor = .white
    var colour502 : UIColor = UIColor(named: "lightGreyText #153 153 153") ?? .lightGray
    var colour503 : UIColor = .lightGray

    public func setupForFont(_ View: UIView?) -> Void {
        let arr_ele = self.arrAllElement(View) as [AnyObject]?
        if let CC = arr_ele?.count{
            for indx in 0..<CC {
                let vw = arr_ele![indx]
                self.setupFontForElement(element: vw as! UIView)
            }
        }
    }

    //MARK: Colour For Icon
    //========================

    func convertTag(element: UIView) -> Void {
        let x : Int = element.tag
        if x <= 0 {return} //TODO: Check For KDFONT Implemented OR NOT
        let xNSNumber = x as NSNumber
        let xString : String = xNSNumber.stringValue
        let type = xString.last ?? "v"
        let str = xString.dropLast()
        let size:Int? = String(str).intValue()
        let types:Int? = String(type).intValue()
        self.setupFont(element: element, size_iPhone: size ?? 0, size_iPad: size ?? 0, type: types ?? 0)
        self.setIconColour(element: element)
    }
    
    func setupFontForElement(element: UIView) -> Void{
        convertTag(element: element)
    }
    public func presentToController(element: UIViewController) -> Void {
        
        
//        let newViewController = SubmitViewController()
//        newViewController.view.backgroundColor = .red
//        // Push the new view controller onto the navigation stack
//        element.navigationController?.pushViewController(newViewController, animated: true)

        
        
        
         let storyboard: UIStoryboard = UIStoryboard(name: "Submit", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
         element.present(vc, animated: true)
     }

    func setIconColour(element: UIView) -> Void {
        if element.isKind(of: UIImageView.self){
            let imgvw = element as? UIImageView
            switch imgvw!.tag {
            case 500:
                KDUtilitis.sharedInstance.setupIconColour(imgvw: imgvw!, colour: colour500)
            case 501:
                KDUtilitis.sharedInstance.setupIconColour(imgvw: imgvw!, colour: colour501)
            case 502:
                KDUtilitis.sharedInstance.setupIconColour(imgvw: imgvw!, colour: colour502)
            case 503:
                KDUtilitis.sharedInstance.setupIconColour(imgvw: imgvw!, colour: colour503)
            default:break
            }
        }
    }
    
    //MARK: Setup Font
    //========================

    func setupFont(element: UIView, size_iPhone: Int, size_iPad: Int, type:Int) -> Void {
        if element.isKind(of: UILabel.self){
            let lbl = element as? UILabel
            if KDUtilitis.sharedInstance.is_ipad{
                lbl!.font = self.setCustomFont(ofSize: CGFloat(size_iPad), types: type)
            }else{
                lbl!.font = self.setCustomFont(ofSize: CGFloat(size_iPhone), types: type)
                lbl?.text = lbl?.text?.localized(lang: getLanguage())
            }
        }
        else if element.isKind(of: UITextView.self){
            let txtvw = element as? UITextView
            if KDUtilitis.sharedInstance.is_ipad{
                txtvw!.font = self.setCustomFont(ofSize: CGFloat(size_iPad), types: type)
            }else{
                txtvw!.font = self.setCustomFont(ofSize: CGFloat(size_iPhone), types: type)
                txtvw?.text = txtvw?.text?.localized(lang: getLanguage())
            }
        }
        else if element.isKind(of: UITextField.self){
            let txtfld = element as? UITextField
            if KDUtilitis.sharedInstance.is_ipad{
                txtfld!.font = self.setCustomFont(ofSize: CGFloat(size_iPad), types: type)
            }else{
                txtfld!.font = self.setCustomFont(ofSize: CGFloat(size_iPhone), types: type)
                txtfld?.text = txtfld?.text?.localized(lang: getLanguage())
//                txtfld?.placeholder = checks(element: txtfld?.placeholder).localized(lang: getLanguage())
            }
        }
        else if element.isKind(of: UIButton.self){
            let btn = element as? UIButton
            if KDUtilitis.sharedInstance.is_ipad{
                btn!.titleLabel?.font = self.setCustomFont(ofSize: CGFloat(size_iPad), types: type)
            }else{
                btn!.titleLabel?.font = self.setCustomFont(ofSize: CGFloat(size_iPhone), types: type)
                btn?.setTitle(btn?.titleLabel?.text?.localized(lang: getLanguage()), for: .normal)
            }
        }
    }
    
    func arrAllElement(_ View: UIView?) -> [AnyHashable]? {
        arrElements = [AnyObject]()
        self.listSubviewsOf(View)
        return arrElements as? [AnyHashable]
    }

    func listSubviewsOf(_ view: UIView?) {
        let subviews = view?.subviews
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
    func saveLanguage(lang: String) -> Void {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: lang)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "selected_lang")
        
    }
    func getLanguage() -> String{
        if UserDefaults.standard.object(forKey: "selected_lang") != nil {
            let decoded  = UserDefaults.standard.object(forKey: "selected_lang") as! Data
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
            let obj = decodedTeams as? String
            return obj!
        }
        return "default"
    }

}

extension String {
    func intValue() -> Int{
        if let myNumber = NumberFormatter().number(from: self) {
            let myInt = myNumber.intValue
            return Int(myInt)
        } else {
            return 0
        }
    }
    func localized(lang:String) ->String {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
                return self
        }

        let str = NSLocalizedString(self, tableName: "LocalizableString", bundle: bundle, value: self, comment: "")
        if self.uppercased() ==  str{

            return self
        }
        return NSLocalizedString(self, tableName: "LocalizableString", bundle: bundle, value: self, comment: "")
    }
}

extension UIView {
    @IBInspectable var enableShadow: Bool {
        get {
            return layer.shadowOpacity > 0
        }
        set {
            if newValue {
                applyShadowStyle()
            } else {
                removeShadowStyle()
            }
        }
    }
    
    private func applyShadowStyle() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.04
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    private func removeShadowStyle() {
        layer.shadowOpacity = 0
    }
}

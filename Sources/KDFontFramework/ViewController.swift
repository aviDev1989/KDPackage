//
//  ViewController.swift
//  KDFont
//
//  Created by Apptunix on 19/10/23.
//

import UIKit
import KDFontFramework

class ViewController: UIViewController {
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtfldInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSubmitClicked(_ sender: Any) {
        lblMessage.text = ""
        lblMessage.text = txtfldInput.text ?? ""
    }
    
}


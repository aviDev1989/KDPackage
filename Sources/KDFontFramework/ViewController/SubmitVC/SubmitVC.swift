//
//  SubmitVC.swift
//  
//
//  Created by Apptunix on 19/10/23.
//

import UIKit

public class SubmitVC: UIViewController {
    public static let storyboardVC = UIStoryboard(name: "SubmitVC", bundle: Bundle.module).instantiateInitialViewController()
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtfldInput: UITextField!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        lblMessage.text = ""
        lblMessage.text = txtfldInput.text ?? ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

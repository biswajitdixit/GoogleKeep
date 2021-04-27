//
//  ForgotTableViewController.swift
//  GoogleKeep
//
//  Created by admin on 11/04/21.
//

import UIKit
import Firebase

class ForgotTableViewController: UITableViewController {
    
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func forgot_PasswordTapped(_sender: Any){
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailField.text!){ (error) in
            if let error = error {
                let alert = Alert.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }else{
            let alert = Alert.createAlertController(title: "Hurray", message: "A password reset email has been sent to your  email id")
            self.present(alert, animated: true, completion: nil)
            let storyboards = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboards.instantiateViewController(identifier: "LoginTableViewController") as! LoginTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    
}

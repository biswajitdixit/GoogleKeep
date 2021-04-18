//
//  LoginTableViewController.swift
//  GoogleKeep
//
//  Created by admin on 06/04/21.
//

import UIKit
import FBSDKLoginKit
import  Firebase
class LoginTableViewController: UITableViewController {
    
    

    @IBOutlet weak var btnFacebook: FBLoginButton!
    @IBOutlet weak var textPassword: UITextField!
    @IBAction func btnLogin(_ sender: UIButton) {
       
       Validation()
    }
    @IBAction func btnSignup(_ sender: UIButton) {
       
        if let signupVc = self.storyboard?.instantiateViewController(identifier: "SignUpTableViewController") as? SignUpTableViewController {
            self.navigationController?.pushViewController(signupVc, animated: true)
        }
    }

    @IBOutlet weak var textEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("console")

        
    }
}
extension LoginTableViewController{
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}
extension LoginTableViewController {
        fileprivate func Validation(){
            if let email = textEmail.text, let password = textPassword.text{
                if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Enter valid email.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])
                }else if !password.validatePassword(){
                    openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])
                }else{
                    // Navigation - Home Screen
                    Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                        if let e = error{
                            print(e.localizedDescription)
                            print("data error")
                        }else{
                           self.performSegue(withIdentifier: "show", sender: self)
                            self.openAlert(title: "Alert", message: "Login Successfully", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                           
                        }
                    }
                }
            
            }else{
                openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        }
        
    }

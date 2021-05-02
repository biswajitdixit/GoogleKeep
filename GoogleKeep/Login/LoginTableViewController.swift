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

    @IBAction func forgotPassword(_ sender: Any) {
        if let loginVc = self.storyboard?.instantiateViewController(identifier: "ForgotTableViewController") as? ForgotTableViewController {
            self.navigationController?.pushViewController( loginVc, animated: true)
        }
    }
    @IBOutlet weak var textEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("console")
        btnFacebook.permissions = ["public_profile", "email"]
        btnFacebook.delegate = self
        
    }
}

extension LoginTableViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else{
            print("User failed to log in with facebbok")
            return
        }
        let credential  = FacebookAuthProvider.credential(withAccessToken: token)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authresult, error in
           
            guard authresult != nil, error == nil else{
                print("Facebook credential login failed")
                return
            }
            
            print("Successfully logged in ")
        
            if let e = error{
                print(e.localizedDescription)
            }else{
                let storyboards = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboards.instantiateViewController(identifier: "ContainerVC") as! ContainerVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
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
                            print("Person not yet Registered")
                            self.openAlert(title: "Alert", message: e.localizedDescription, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                        }else{
                        let storyboards = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboards.instantiateViewController(identifier: "ContainerVC") as! ContainerVC
                        self.navigationController?.pushViewController(vc, animated: true)
                            
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

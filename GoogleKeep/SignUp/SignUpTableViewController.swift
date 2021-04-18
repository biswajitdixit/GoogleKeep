//
//  SignUpTableViewController.swift
//  GoogleKeep
//
//  Created by admin on 07/04/21.
//

import UIKit
import Firebase

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var textConfirmpassword: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textusername: UITextField!
    @IBOutlet weak var imageProfile: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageProfile.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)   {
        openGallery()
    }
    @IBAction func btnLogin(_ sender: UIButton) {
      
      
    }
    
    @IBAction func buttonSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
         if imageProfile.image?.pngData() != imgSystem?.pngData(){
             if let email = textEmail.text , let password = textPassword.text , let Username = textusername.text,let confirmPassword = textConfirmpassword.text{
                 if Username == ""{
                    openAlert(title: "Alert", message: "Please Enter User name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                    print("please enter username")
                 }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please Enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                    print("Email is not valid")
                     }else if !password.validatePassword(){
                        openAlert(title: "Alert", message: "Please Enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                        print("Password is not valid")
                     }else{
                     if confirmPassword == ""{
                        openAlert(title: "Alert", message: "Please Enter confirm password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                        print("please enter confirm password")
                     }else{
                         if password == confirmPassword {
                            print("navigation code")
                         }else{openAlert(title: "Alert", message: "Password doesn't match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                            print("password doesn't match")
                         }
                     }
                 }
                Auth.auth().createUser(withEmail: email , password: confirmPassword ) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    }else{
                        self.openAlert(title: "Alert", message: "SignUp Successfully", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                        self.performSegue(withIdentifier: "showData", sender: self)

                        //Navigation controller
                    }
                }
             }else{
                 print("Please Check Your Details")
             }
           
         }else{openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
            print("Please select profile picture")
         }    }
   
    
}

extension SignUpTableViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        present(picker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imageProfile.image = img
            
        }
        dismiss(animated: true)
    }
}

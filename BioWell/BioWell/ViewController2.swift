//
//  ViewController2.swift
//  BioWell
//
//  Created by kuet on 14/11/23.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
class ViewController2: UIViewController {

    @IBOutlet var errors: UILabel!
    @IBOutlet var ageid: UITextField!
    @IBOutlet var passid: UITextField!
    @IBOutlet var phoneid: UITextField!
    @IBOutlet var emailid: UITextField!
    @IBOutlet var nameid: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errors.isHidden=true
        passid.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Signup(_ sender: Any) {
        var name=nameid.text ?? ""
        var email = emailid.text ?? ""
        var phone=phoneid.text ?? ""
        var age=ageid.text ?? ""
        var pass = passid.text ?? ""
        if(name.isEmpty && email.isEmpty && phone.isEmpty && age.isEmpty && pass.isEmpty){
            showAlert(message: "Fill the Required Informations")
        }
        else if !isValidEmail(email){
            showAlert(message: "Invalid Email")
        }
        else{
            let progressIndicator = UIActivityIndicatorView(style: .large)
            progressIndicator.center = view.center
            view.addSubview(progressIndicator)
            progressIndicator.startAnimating()
            Auth.auth().createUser(withEmail: email, password:pass) { result, err in
                if let err=err{
                    self.showAlert(message: "Error on creating User")
                    progressIndicator.stopAnimating()
                }
                else {
                    let ref = Database.database().reference().child("users")
                    let user = ["name": name, "email":email,"mobile":phone,"age":age,"userid":result!.user.uid]
                    
                    let newChildRef = ref.child(result!.user.uid)
                    newChildRef.setValue(user) { (error, ref) in
                        progressIndicator.stopAnimating()
                        
                        if error == nil {
                            self.clearError()
                            progressIndicator.stopAnimating()
                            let storybord = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                            self.view.window?.rootViewController = storybord
                            self.view.window?.makeKeyAndVisible()
                        } else {
                            self.showAlert(message: "Error on Uploading")
                        }
                    }

                }
            }
        }
        
    }
    @IBAction func Signin(_ sender: Any) {
        clearError()
        
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.view.window?.rootViewController = storybord
        self.view.window?.makeKeyAndVisible()
    }
    func showError(message: String) {
        errors.text = message
        errors.isHidden = false
    }

    func clearError() {
        errors.text = nil
        errors.isHidden = true
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

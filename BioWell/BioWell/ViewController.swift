//
//  ViewController.swift
//  BioWell
//
//  Created by kuet on 14/11/23.
//

import UIKit
import FirebaseAuth
import Foundation

class ViewController: UIViewController {

    @IBOutlet var errors: UILabel!
    @IBOutlet var passid: UITextField!
    @IBOutlet var emailid: UITextField!
    var email:String = ""
    var pass:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        errors.isHidden=true
        // Set the secure text entry for the password field
        passid.isSecureTextEntry = true
        
    }


    @IBAction func Signupbutton(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        self.view.window?.rootViewController = storybord
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func Signinbutton(_ sender: Any) {
        email=emailid.text ?? ""
        pass=passid.text ?? ""
        if(email.isEmpty && pass.isEmpty){
            showAlert(message:"Enter Email and Password")
        }
        else if(email.isEmpty){showAlert(message: "Email is empty!")

        }
        else if(pass.isEmpty){showAlert(message: "Pass is empty!")}
        else{
            let progressIndicator = UIActivityIndicatorView(style: .large)
            progressIndicator.center = view.center
            view.addSubview(progressIndicator)
            progressIndicator.startAnimating()
            Auth.auth().signIn(withEmail:email, password: pass) { result, error in
                if error != nil {
                    self.showAlert(message: "Email or password is invalid")
                    progressIndicator.stopAnimating()
                }
                else{
                    self.clearError()
                    self.saveDataToUserDefaults()
                    progressIndicator.stopAnimating()
                    let storybord = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                     self.navigationController?.pushViewController(storybord, animated: true)
//                    self.view.window?.rootViewController = storybord
//                    self.view.window?.makeKeyAndVisible()
                }
            }
            
            
           
        }
 }
    func showError(message: String) {
        errors.text = message
        errors.isHidden = false
    }

    func clearError() {
        errors.text = nil
        errors.isHidden = true
    }
    func saveDataToUserDefaults() {
        let dataToSave = Auth.auth().currentUser?.uid

        // Get UserDefaults instance
        let defaults = UserDefaults.standard

        // Save data
        defaults.set(dataToSave, forKey: "userid")

        // Synchronize to make sure the data is saved immediately
        defaults.synchronize()
    }
    func retrieveDataFromUserDefaults() -> String? {
        // Get UserDefaults instance
        let defaults = UserDefaults.standard

        // Retrieve data
        if let retrievedData = defaults.string(forKey: "userid") {
            return retrievedData
        } else {
            return nil
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}


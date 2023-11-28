//
//  adddataview.swift
//  BioWell
//
//  Created by Ahsan Habib Swassow on 26/11/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class adddataview: UIViewController {
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var errors: UILabel!
    @IBOutlet weak var phy: UISwitch!
    @IBOutlet weak var cm: UITextField!
    @IBOutlet weak var mmol: UITextField!
    @IBOutlet weak var dias: UITextField!
    @IBOutlet weak var sys: UITextField!
    @IBOutlet weak var m: UITextField!
    @IBOutlet weak var kg: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errors.isHidden=true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func adata(_ sender: Any) {
        if (age.text?.isEmpty ?? true) || (sys.text?.isEmpty ?? true) || (kg.text?.isEmpty ?? true) || (m.text?.isEmpty ?? true) || (dias.text?.isEmpty ?? true) || (mmol.text?.isEmpty ?? true) || (cm.text?.isEmpty ?? true) {
            showAlert(message: "Fill all the Field")
            
        } else {
            let progressIndicator = UIActivityIndicatorView(style: .large)
            progressIndicator.center = view.center
            view.addSubview(progressIndicator)
            progressIndicator.startAnimating()
            
            struct YourDataModel: Codable {
                var userid: String?
                // Add properties for your data
                var age: Int
                var sys: Double
                var dy : Double
                var kg: String?
                var m: String?
                var glu: Double
                var bmi : Double
                var result : String?
                func toAnyObject() -> Any {
                    return [
                        "age": age,
                        "sys": sys,
                        "dy": dy,
                        "kg": kg!,
                        "m": m!,
                        "glu": glu,
                        "bmi" : bmi,
                        "result" : result!
                        // Add other properties as needed
                    ]
                }
            }

            var risks : String = ""
            
            let agetxt = age.text!
            let ageValue = Int(agetxt)
            
            
            let systxt = sys.text!
            let sysValue = Double(systxt) ?? 0.0
            
            let diastxt = dias.text!
            let diasValue = Double(diastxt) ?? 0.0
            
            let mmoltxt = mmol.text!
            let mmolValue = Double(mmoltxt) ?? 0.0
            
            let cmtxt = cm.text!
            let cmValue = Double(cmtxt) ?? 0.0
            
            var count: Int = 0
            let isSwitchOn = phy.isOn
            var bmic : Double = 0.0
            if let kgtxt = kg.text, let kgValue = Double(kgtxt),
               let mtxt = m.text, let mValue = Double(mtxt) {
                let bmi: Double = kgValue / (mValue * mValue)
                if bmi > 25 && bmi < 30 {
                    count += 1
                    bmic = bmi
                }
                else {
                    count += 3
                    bmic = bmi
                }
            }
            
            
            
            // Use the value as needed
            if isSwitchOn {
                count += 2
            }
            if let age = ageValue, age > 45, age < 54 {
                count += 2
            }
            if let age = ageValue, age > 55, age < 64 {
                count += 3
            }
            if let age = ageValue, age > 64 {
                count += 4
            }
            if cmValue > 102 {
                count += 4
            }
            
            if  mmolValue > 6, mmolValue < 7 {
                count += 5
            } else {
                count += 10
            }
            
            if sysValue > 120 {
                if diasValue < 80 {
                    count += 3
                }
            }
            
            
            
            
            if count > 0 , count < 7 {
                risks = "Low Risk of Diabetes 1%"
            }
            else if count > 6 , count < 12 {
                risks = "Slightly Risk of Diabetes 3%"
            }
            else if count > 11 , count < 15 {
                risks = "Moderate Risk of Diabetes 15%"
            }
            else if count > 14 , count < 21 {
                risks = "High Risk of Diabetes 30%"
            }
            else if count > 20 {
                risks = "Very High Risk of Diabetes 50%"
            }
            
            let databaseRef = Database.database().reference()

            let dataToAdd = YourDataModel(age: ageValue ?? 0, sys: sysValue, dy: diasValue, kg: kg.text, m: m.text, glu: mmolValue, bmi: bmic, result: risks)

            guard let userId = Auth.auth().currentUser?.uid else {
                // Handle the case where the user is not logged in
                return
            }
            let userRef = databaseRef.child("health").child(userId).childByAutoId()
            userRef.setValue(dataToAdd.toAnyObject())
            progressIndicator.stopAnimating()
            let storybord = self.storyboard?.instantiateViewController(withIdentifier: "healthmonitor") as! healthmonitor
            self.navigationController?.pushViewController(storybord, animated: true)

        }
        
        
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

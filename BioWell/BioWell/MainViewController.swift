//
//  MainViewController.swift
//  BioWell
//
//  Created by kuet on 14/11/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        v1.isHidden = true
        btn1.isHidden = true
        btn2.isHidden = true
    }
    
    @IBAction func menus(_ sender: Any) {
        if v1.isHidden {
            v1.isHidden = false
            btn1.isHidden = false
            btn2.isHidden = false
        }
        else {
            v1.isHidden = true
            btn1.isHidden = true
            btn2.isHidden = true
        }
    }
    
    
    @IBAction func btn1(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "userprofileshow") as! userprofileshow
         self.navigationController?.pushViewController(storybord, animated: true)
    }
    
    @IBAction func btn2(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.view.window?.rootViewController = storybord
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func consultancy(_ sender: Any) {
        // Assuming you are in InitialViewController
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "consultantview") as! consultantview
         self.navigationController?.pushViewController(storybord, animated: true)
    }
    @IBAction func faq(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "faqview") as! faqview
         self.navigationController?.pushViewController(storybord, animated: true)
    
    }
    
    @IBAction func corona(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "Coronaview") as! Coronaview
         self.navigationController?.pushViewController(storybord, animated: true)
    }
    @IBAction func healthmonitor(_ sender: Any) {
        let storybord = self.storyboard?.instantiateViewController(withIdentifier: "healthmonitor") as! healthmonitor
         self.navigationController?.pushViewController(storybord, animated: true)
    }
    
}

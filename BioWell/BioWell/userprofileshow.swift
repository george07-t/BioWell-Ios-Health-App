//
//  userprofileshow.swift
//  BioWell
//
//  Created by Ahsan Habib Swassow on 27/11/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class userprofileshow: UIViewController {
    @IBOutlet weak var ages: UILabel!
    @IBOutlet weak var mails: UILabel!
    @IBOutlet weak var phones: UILabel!
    @IBOutlet weak var names: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUserProfile()
        
        
    }
    func fetchUserProfile() {
        let progressIndicator = UIActivityIndicatorView(style: .large)
        progressIndicator.center = view.center
        view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let ref = Database.database().reference().child("users").child(userId)

        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                self.names.text = userData["name"] as? String
                self.ages.text = userData["age"] as? String
                self.mails.text = userData["email"] as? String
                self.phones.text = userData["mobile"] as? String
            }
        }
        progressIndicator.stopAnimating()
    }
}

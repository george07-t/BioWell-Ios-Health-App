import UIKit
import FirebaseAuth
import FirebaseDatabase

class healthmonitor: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tables: UITableView!
    struct HealthDataModel {
        var age: Int
        var sys: Double
        var dy: Double
        var kg: String
        var m: String
        var glu: Double
        var bmi: Double
        var result: String
    }

    var healthDataArray: [HealthDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let progressIndicator = UIActivityIndicatorView(style: .large)
        progressIndicator.center = view.center
        view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
        tables.dataSource = self
        tables.delegate = self
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let databaseRef = Database.database().reference()

        let userRef = databaseRef.child("health").child(userId)

//        userRef.observe(.value) { snapshot in
//            guard let userData = snapshot.value as? [String: Any] else {
//                print("Invalid data format")
//                return
//            }
        userRef.observe(.childAdded, with: {(snapshot) in
            guard let userData = snapshot.value as? [String: Any] else {
                print("Invalid data format")
                return
            }
            
            // Assuming 'userData' is a dictionary with your data
            let age = userData["age"] as? Int
            let sys = userData["sys"] as? Double
            let dy = userData["dy"] as? Double
            let kg = userData["kg"] as? String
            let m = userData["m"] as? String
            let glu = userData["glu"] as? Double
            let bmi = userData["bmi"] as? Double
            let result = userData["result"] as? String
            let healthData = HealthDataModel(age: age ?? 0, sys: sys ?? 0.0, dy: dy ?? 0.0, kg: kg ?? "", m: m ?? "", glu: glu ?? 0.0, bmi: bmi ?? 0.0, result: result ?? "")
            
            // Append the new data to your array
            self.healthDataArray.append(healthData)
            
            // Reload the table view to reflect the changes
            self.tables.reloadData()
            progressIndicator.stopAnimating()
            
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return healthDataArray.count
        }
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Adjust this value to set the space between cells
    }


        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)// Replace with your actual cell class

            // Configure the cell with data from your array
            let healthData = healthDataArray[indexPath.row]
            cell.textLabel?.text = "Age: \(healthData.age), Pressure : \(healthData.sys)-\(healthData.dy)\n BMI: \(healthData.bmi)\n Glucose Level: \(healthData.glu)\n Result: \(healthData.result)"
            // Configure other labels with corresponding data properties
            cell.textLabel?.numberOfLines = 5
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
    @IBAction func addme(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "adddataview") as! adddataview
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

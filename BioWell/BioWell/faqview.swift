//
//  faqview.swift
//  BioWell
//
//  Created by Ahsan Habib Swassow on 23/11/23.
//

import UIKit

class faqview: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let questions = [
           "Q1. Please Tell me techniques that can help alleviate stress and promote relaxation.",
           "Q2. Tell me some key principles that can help me to a balanced diet effectively?",
           "Q3. Can you Suggest me balanced diet routine for me?",
           "Q4. My BMI index is tooh high what should I do now?",
           "Q5. Can you give me some meditation technique to refresh my mind? ",
           "Q6. Can you tell me the Corona symptoms?",
           "Q7. Give me some advices for post Corona life style.",
           "Q8. Can you suggest me some treatment for diabetes?",
           "Q9. High gluecosse level solution",
           "Q10. Have I contracted dengue fever?"
       ]
    

    
    @IBOutlet weak var faqtable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faqtable.dataSource = self
        faqtable.delegate = self
        faqtable.separatorStyle = .singleLine
        faqtable.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return questions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)// Replace with your actual cell class

            cell.textLabel?.numberOfLines = 3
            cell.textLabel?.textColor = UIColor.white
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 8.0
            cell.layer.shadowRadius = 2.0
        
            cell.textLabel?.text = questions[indexPath.row]
            // Configure other labels with corresponding data properties

            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // Set the fixed height for the cells
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedQuestion = indexPath.row

         // Assuming you have another view controller with a label named "questionLabel"
         let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "faqshow") as! faqshow
         nextViewController.selectedQuestionIndex = selectedQuestion

         navigationController?.pushViewController(nextViewController, animated: true)
     }
}


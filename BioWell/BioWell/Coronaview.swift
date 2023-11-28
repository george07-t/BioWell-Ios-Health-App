//
//  Coronaview.swift
//  BioWell
//
//  Created by Ahsan Habib Swassow on 23/11/23.
//

import UIKit
import Foundation


class Coronaview: UIViewController {

    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchcountry(_ sender: Any) {
        let progressIndicator = UIActivityIndicatorView(style: .large)
        progressIndicator.center = view.center
        view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
        guard let countryName = countryTextField.text, !countryName.isEmpty else {
            progressIndicator.stopAnimating()
            showAlert(message: "Please enter a country name.")
            return
        }
        let headers = [
            "X-RapidAPI-Key": "5035303c62mshdf39584b3bcca7cp1566a9jsnefd299c149af",
            "X-RapidAPI-Host": "covid-19-tracking.p.rapidapi.com"
        ]
        guard let url = URL(string: "https://covid-19.dataflowkit.com/v1/\(countryName)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                    
                    if let activeCases = jsonData?["Active Cases_text"],
                       let country = jsonData?["Country_text"],
                       let lastUpdate = jsonData?["Last Update"],
                       let newCases = jsonData?["New Cases_text"],
                       let newDeaths = jsonData?["New Deaths_text"],
                       let totalCases = jsonData?["Total Cases_text"],
                       let totalDeaths = jsonData?["Total Deaths_text"],
                       let totalRecovered = jsonData?["Total Recovered_text"] {
                        
                        DispatchQueue.main.async {
                            self.countryLabel.isHidden = false
                            self.countryLabel.text = "Active Cases: \(activeCases)\nCountry: \(country)\nLast Update: \(lastUpdate)\nNew Cases: \(newCases)\nNew Deaths: \(newDeaths)\nTotal Cases: \(totalCases)\nTotal Deaths: \(totalDeaths)\nTotal Recovered: \(totalRecovered)"
                        }
                        
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            }
        }
        progressIndicator.stopAnimating()
        dataTask.resume()
       
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

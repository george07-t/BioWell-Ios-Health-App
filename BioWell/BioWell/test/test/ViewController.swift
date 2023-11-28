//
//  ViewController.swift
//  test
//
//  Created by Ahsan Habib Swassow on 27/11/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var lab1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }

    func fetchData() {
           let headers = [
               "X-RapidAPI-Key": "5035303c62mshdf39584b3bcca7cp1566a9jsnefd299c149af",
               "X-RapidAPI-Host": "covid-19-tracking.p.rapidapi.com"
           ]
           let countryName="usa"
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
                               self.lab1.text = "Active Cases: \(activeCases)\nCountry: \(country)\nLast Update: \(lastUpdate)\nNew Cases: \(newCases)\nNew Deaths: \(newDeaths)\nTotal Cases: \(totalCases)\nTotal Deaths: \(totalDeaths)\nTotal Recovered: \(totalRecovered)"
                           }
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                   }
               }
           }

           dataTask.resume()
       }
}


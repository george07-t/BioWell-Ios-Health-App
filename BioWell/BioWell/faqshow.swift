//
//  faqshow.swift
//  BioWell
//
//  Created by kuet on 27/11/23.
//

import UIKit

class faqshow: UIViewController {
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
    let answer = [
    "Answer:\n\tTo reduce stress, practice deep breathing exercises, mindfulness meditation,regular exercise, maintain a balanced diet with fruits, vegetables, whole grains, lean proteins,and healthy fats, and prioritize sleep. Engage in mindfulness meditation, focus on the present moment,and find a workout routine that you enjoy. Avoid excessive caffeine, sugar, and processed foods.",
    "Answer:\n\tTo maintain a balanced diet, include a variety of nutrient-dense foods, practice portion control,enjoy moderation, and aim for regular meal timing. Stay hydrated by drinking enough water throughout the day,practice mindful eating, limit added sugars and processed foods, plan meals in advance, read food labels, and seek professional guidance. By incorporating these principles into daily routines, individuals can develop habits that support a balanced diet, leading to improved overall health and well-being. By incorporating these strategies, individuals can develop habits that support a balanced diet and improved overall health.",
    "Answer:\n\tBreakfast includes whole grain cereal with fresh fruits, low-fat yogurt, nuts, and water. Mid-morning snacks include apple slices, carrot sticks with hummus, and green tea. Lunch includes grilled chicken salad with mixed greens, vegetables, and beans. Afternoon snacks include Greek yogurt parfait, cheese crackers, and whole grain crackers. Dinner includes baked salmon with roasted vegetables, Quinoa or brown rice, and mixed salad. Evening snacks include mixed berries, popcorn, and cottage cheese.",
    "Answer:\n\tTo lower your BMI and improve overall health, consult a healthcare professional, focus on a balanced diet, control portion sizes, incorporate regular physical activity, make lifestyle changes, monitor progress, get enough sleep, and manage stress. Focus on gradual, healthy changes over time, avoid crash diets, and maintain a healthy weight for better overall well-being. Aim for 7-8 hours of quality sleep per night.",
    "Answer:\n\tStart with short sessions (5-10 minutes) and gradually increase the duration as you become more comfortable. Mindfulness Meditation involves sitting comfortably, closing eyes, and focusing on breath. Pay attention to breath sensations, and gently return focus when mind wanders without judgment. Engage in a slow, mindful walk, paying attention to each step and foot sensation, indoors or outdoors, focusing on the movements involved. ",
    "Answer:\n\tFever, persistent cough, shortness of breath, fatigue, muscle or body aches, sore throat, loss of taste or smell, headaches, congestion or runny nose, and gastrointestinal symptoms are common symptoms of a cold. These symptoms can be severe, causing difficulty breathing, fatigue, muscle or body aches, and may be similar to symptoms of the common cold. If you have these sysmtops immediately go to doctor.",
    "Answer:\n\tMaintain good hygiene habits, stay updated on vaccinations, adapt to remote work, prioritize physical and mental well-being, follow travel precautions, reintegrate into social interactions, manage finances prudently, adopt sustainable practices, engage in continuous learning, offer community support, and be flexible and adaptable to the pandemic.",
    "Answer:\n\tInsulin is essential for managing blood sugar in people with type 1 diabetes, as well as type 2 diabetes or gestational diabetes. Insulin can be injected orally, using devices like insulin pumps or continuous glucose monitors. Hybrid closed loop systems are also available for type 1 diabetes. Other medications, such as Metformin and SGLT2 inhibitors, may be prescribed to help the pancreas release more insulin. Pancreas and Islet transplants are also options, but they pose risks and require a lifetime of immune-suppressing drugs. Immediately Go to doctors if situation is conerning.",
    "Answer:\n\tStay hydrated, engage in moderate exercise, adjust your diet to low glycemic index foods, take prescribed medication, check for ketones, contact your healthcare provider if glucose levels remain high, and follow your diabetes management plan. Follow your healthcare provider's advice and seek immediate medical attention if symptoms persist.",
    "Answer:\n\tDengue fever typically manifests 4-10 days after bites, causing high fever, headache, eye pain, joint and muscle pain, rash, and fatigue. Severe cases, known as dengue hemorrhagic fever or dengue shock syndrome, can be life-threatening. Predominant in tropical and subtropical regions. If you have these sysmtops immediately go to doctor."

    ]
    
    @IBOutlet weak var answers: UILabel!
    var selectedQuestionIndex: Int?
    @IBOutlet weak var questionno: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = selectedQuestionIndex {
            let selectedQuestion = questions[index]
            let ans = answer[index]
            questionno.text = selectedQuestion
            answers.text = ans
        }
        // Do any additional setup after loading the view.
    }
    



}

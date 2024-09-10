//
//  QuizViewController.swift
//  faysalmidterm2
//
//  Created by csis on 5/10/24.
//  Copyright © 2024 csis. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var damnimg: UIImageView!
    @IBOutlet weak var timerlabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var artisttxt: UITextField!
    @IBOutlet weak var releasepick: UIDatePicker!
    @IBOutlet weak var drakequestion: UISegmentedControl!
    
    @IBOutlet weak var sbmtbtm: UIButton!
    @IBOutlet weak var begin: UIButton!
    
    @IBOutlet weak var nameans: UILabel!
    @IBOutlet weak var dateans: UILabel!
    @IBOutlet weak var drakeans: UILabel!
    
    
    var timer: Timer?
    var secondsElapsed = 0
    
    private var drakeQuestionAnswered = false
    private var releaseDateCorrect = false
    private var artistCorrect = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTimer()
        setupDatePicker()
        nameans.isHidden = true
        dateans.isHidden = true
        drakeans.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func beginTest(_ sender: UIButton) {
        startTimer()
    }
    func startTimer() {
        secondsElapsed = 0
        timerlabel.text = "Time: 0s"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        secondsElapsed += 1
        timerlabel.text = "Time: \(secondsElapsed)s"
    }
    
    func resetTimer() {
        stopTimer()
        secondsElapsed = 0
        timerlabel.text = "Time: 0s"
    }
    
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func setupDatePicker() {
        releasepick.datePickerMode = .date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        if let defaultDate = formatter.date(from: "2017/04/14") {
            releasepick.date = defaultDate
        }
    }
    @IBAction func submitAnswers(_ sender: UIButton) {
        checkReleaseDate()
        checkDrakeQuestion()
        checkArtistAnswer()
        
        if artistCorrect && releaseDateCorrect && drakeQuestionAnswered {
            stopTimer()
            saveHighScore()
            showAlertWithScore()
            
            nameans.isHidden = false
            dateans.isHidden = false
            drakeans.isHidden = false
        }else{
            let alert = UIAlertController(title: "Keep Trying", message: "Not all answers are correct. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
    private func checkArtistAnswer() {
        artistCorrect = (artisttxt.text?.lowercased() == "kendrick lamar")
    }
    func saveHighScore() {
        let highScores = UserDefaults.standard.dictionary(forKey: "HighScores") as? [String: Int] ?? [:]
        if let userName = nameTextField.text, !userName.isEmpty {
            var newScores = highScores
            newScores[userName] = secondsElapsed
            UserDefaults.standard.set(newScores, forKey: "HighScores")
        }
    }
    
    func showAlertWithScore() {
        let message = "Congratulations! Your time was \(secondsElapsed) seconds."
        let alert = UIAlertController(title: "Quiz Completed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func checkReleaseDate() {
        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: releasepick.date)
        let correctDateComponents = DateComponents(year: 2017, month: 4, day: 14)
        
        releaseDateCorrect = (selectedDateComponents == correctDateComponents)
    }
    
    private func checkDrakeQuestion() {
        if !drakeQuestionAnswered { // Only check the first time
            drakeQuestionAnswered = (drakequestion.selectedSegmentIndex == 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

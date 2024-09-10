//
//  MusicPlayerViewController.swift
//  faysalmidterm2
//
//  Created by csis on 5/10/24.
//  Copyright © 2024 csis. All rights reserved.
//

import UIKit


class MusicPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var songPicker: UIPickerView!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    // Data
    let songs = ["BLOOD.", "DNA.", "YAH.", "ELEMENT.", "FEEL.", "LOYALTY. ft. Rihanna", "PRIDE.", "HUMBLE.", "LUST.", "LOVE. ft. Zacari", "XXX. ft. U2", "FEAR.", "GOD.", "DUCKWORTH."]
    var songRatings: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songPicker.delegate = self
        songPicker.dataSource = self
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        ratingSlider.value = 0
        updateRatingLabel()
    }
    
    // MARK: UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return songs.count
    }
    
    // MARK: UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return songs[row]
    }
    
    // MARK: Actions
    @IBAction func ratingSliderChanged(_ sender: UISlider) {
        updateRatingLabel()
    }
    
    func updateRatingLabel() {
        let roundedValue = round(ratingSlider.value)
        ratingLabel.text = "Rate: \(Int(roundedValue))"
    }
    
    @IBAction func submitRating(_ sender: UIButton) {
        let selectedSong = songs[songPicker.selectedRow(inComponent: 0)]
        let rating = Int(round(ratingSlider.value))
        songRatings[selectedSong] = rating
        UserDefaults.standard.set(rating, forKey: selectedSong)
        
        // Present an alert thanking the user
        let alert = UIAlertController(title: "Thank You!", message: "Thank you for rating \(selectedSong) with a rating of \(rating).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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

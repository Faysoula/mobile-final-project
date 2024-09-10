//
//  InfoViewController.swift
//  faysalmidterm2
//
//  Created by csis on 5/10/24.
//  Copyright © 2024 csis. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var openCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateOpenCount()
    }
    
    func updateOpenCount() {
        let openCount = UserDefaults.standard.integer(forKey: "appOpenCount")
        openCountLabel.text = "opened \(openCount) times"
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

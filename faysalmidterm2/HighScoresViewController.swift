import UIKit

class HighScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var highScores: [(name: String, time: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHighScores()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadHighScores() {
        if let scoresDict = UserDefaults.standard.dictionary(forKey: "HighScores") as? [String: Int] {
            highScores = scoresDict.map { ($0.key, $0.value) }
            highScores.sort { $0.time < $1.time }
        }
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        let score = highScores[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1). \(score.name) - \(score.time) seconds"
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

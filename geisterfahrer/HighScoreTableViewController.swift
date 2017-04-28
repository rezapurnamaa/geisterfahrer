//
//  HighScoreTableViewController.swift

import UIKit

class HighScoreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var highscoreView: UITableView!
    
    var scoreData = Array(HighScore().loadData().allKeys as! [Int]).sorted(by: >).map { "\($0) von \(HighScore().loadData()[$0]!)" }
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // liefert die Anzahl der Sectionen
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // liefert die Anzahl der Zeilen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scoreData.count<=10 {return scoreData.count
        }
        else {return 10}
    }
    
    
    // liefert die Zellen ( mit Inhalt )
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableRow")
        cell!.textLabel?.text = String(scoreData[indexPath.row])
        return cell!
    }
    
}


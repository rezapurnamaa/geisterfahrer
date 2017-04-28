//
//  HighScoreData.swift

import Foundation


class HighScore {
    
    var highscoreData = Dictionary<Int, String>()
    let akey = "aKey"
    let defaults: UserDefaults = UserDefaults.standard

    func saveData(_ name: String, score: Int) {
        highscoreData = self.loadData() as! Dictionary<Int, String>
        self.highscoreData.updateValue(name, forKey: score)
        let nsdataarray = NSKeyedArchiver.archivedData(withRootObject: highscoreData)
        defaults.set(nsdataarray, forKey: akey)
        defaults.synchronize()
    }
    
    func loadData() -> NSDictionary {
        if let testArray = defaults.object(forKey: akey){
            let dictionary:NSDictionary? = (NSKeyedUnarchiver.unarchiveObject(with: testArray as! Data) as! NSDictionary)
            return (dictionary!)
        }
        return NSDictionary()
    }
    
}

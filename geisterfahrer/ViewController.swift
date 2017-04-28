import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var displayTimeLabel: UILabel!
    @IBOutlet weak var finishTxt: UITextField!
    @IBOutlet weak var highscoreBtn: UIBarButtonItem!
    @IBOutlet weak var crashCounterTxt: UITextField!
    @IBOutlet weak var timeLabel: UITextField!
    
    var score:Int = 0
    var geisterFahrer = GeisterFahrer()
    var autoFahrer = [AutoFahrer(),AutoFahrer(),AutoFahrer(),AutoFahrer(),AutoFahrer()]
    var gameFinishedByTime = 0
    let screenWidthGlobal = Double(UIScreen.main.bounds.size.width)
    var timer: Timer?
    var scoring = Timer()
    var initialSpeed: Double = 0.075
    var scoringData = HighScore()
    var tField = UITextField()
    
    let kUserInfoKey = "startDate"

    
    
    @IBAction func moveGeisterFahrer(_ sender: UISlider) {
        // Breite des geisterfahreres
        let geisterFahrerWidth = Float(geisterFahrer.bounds.size.width)
        // Breite des Screens
        let screenWidth = Float(UIScreen.main.bounds.size.width)
        // Strecke, die zurückgelegt werden kann ohne das Bild zu verlassen
        let distance = screenWidth - geisterFahrerWidth
        // horizontale Bewegung des geisterfahrers durch den Slider
        geisterFahrer.frame.origin.x = CGFloat((sender.value * distance))
        
        print(geisterFahrer.frame.origin.y)
        if geisterFahrer.countedCrashs == 3{
            geisterFahrer.frame.origin.x = CGFloat(((1-sender.value) * distance))
        }
    }
    
    
    
    override func viewDidLoad() {
        
        displayTimeLabel.text = "\(score)"
        self.view.addSubview(geisterFahrer)
        for auto in autoFahrer{
            auto.center.y = CGFloat((drand48() * -(Double(UIScreen.main.bounds.size.height))))
            self.view.addSubview(auto)
        }
        
        super.viewDidLoad()
//        startTimer()
        scoring = Timer.scheduledTimer(timeInterval: 1, target:self,
                                                         selector:#selector(ViewController.countUp), userInfo: nil, repeats: true)
//        speedTxt.text = String(geisterFahrer.speed)
        geisterFahrer.center.x = UIScreen.main.bounds.midX
        timer = Timer.scheduledTimer(timeInterval: initialSpeed, target:self,
                                                       selector:#selector(ViewController.moveAutoInArray), userInfo: nil, repeats: true)
    }
    
    //start timer using callback
    func startTimer() {
        let userInfo = [kUserInfoKey: Date()]
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(timerCallback(_:)), userInfo: userInfo, repeats: true)
    }
    
    
    @objc func timerCallback(_ timer: Timer){
        let userInfo = timer.userInfo as! Dictionary<String, Date>
        if let startDate = userInfo[kUserInfoKey]{
            let timerFormatter = DateComponentsFormatter()
            timerFormatter.allowedUnits = [.minute, .second]
            timerFormatter.zeroFormattingBehavior = .pad
            let timeDIff = timer.fireDate.timeIntervalSince(startDate)
            let diffString = timerFormatter.string(from: timeDIff)
            print(diffString!)
            timeLabel.text = diffString
            if timeDIff > 60.0 || geisterFahrer.countedCrashs > 3 {
                timer.invalidate()
                scoring.invalidate()

            }
//            else if geisterFahrer.countedCrashs > 3 {
//                timer.invalidate()
//            }
        }
    }

    
    func crash(_ auto: AutoFahrer){
        auto.center.y = CGFloat((drand48() * -(Double(UIScreen.main.bounds.size.height))))
        crashCounterTxt.text = String("Crashes: \(geisterFahrer.countedCrashs  + 1)")
        geisterFahrer.countedCrashs += 1
        geisterFahrer.speed -= 5
//        speedTxt.text = String(geisterFahrer.speed)
        if geisterFahrer.countedCrashs  == 3 {
            geisterFahrer.isHidden = true
            timer?.invalidate()
            finishTxt.textColor = UIColor.red
            finishTxt.isHidden = false
            scoring.invalidate()
        }
        
        
    }
    
    
    func countUp(){
        gameFinishedByTime = gameFinishedByTime + 1
        timeLabel.text = String(gameFinishedByTime)
        if gameFinishedByTime == 60 {
            scoring.invalidate()
            timer?.invalidate()
            finishTxt.text = "finished"
            finishTxt.textColor = UIColor.green
            finishTxt.isHidden = false
            geisterFahrer.isHidden = true
            self.finisher()
        }
        score = (score + Int(geisterFahrer.speed))
        displayTimeLabel.text = "Score: \(score)"
    }
    
    
    func confTextField(_ textField: UITextField!){
        
        textField.placeholder = "Name"
        tField = textField
    }
    
    func finisher(){
        let alert = UIAlertController(title: "Name für die Bestenliste", message: "", preferredStyle: UIAlertControllerStyle.alert)

        alert.addTextField(configurationHandler: confTextField)
        alert.addAction(UIAlertAction(title: "Speichern", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            
//            self.scoringData.loadData()
            self.scoringData.saveData(self.tField.text!, score: self.score)
            self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)

        
        
    }
    
    func moveAutoInArray(){
        for auto in autoFahrer {
            auto.moveImage()
            
            // crash detection
            if  geisterFahrer.countedCrashs < 3 {
                if auto.frame.intersects(geisterFahrer.frame){
                    crash(auto)
                }
                // finish the game
                if geisterFahrer.countedCrashs  == 3 {
                    geisterFahrer.isHidden = true
                    timer?.invalidate()
                    self.finisher()
                    

                }
                
            }
        }
        
    }
}


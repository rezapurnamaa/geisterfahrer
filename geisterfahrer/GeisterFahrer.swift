

import Foundation
import UIKit

class GeisterFahrer: UIImageView {
    let geisterName = "geister"
    var geisterAuto = UIImage (named: "auto.png")
    var speed = 21
    var countedCrashs = 0
 
    init(){
        super.init(image: geisterAuto)
        self.center.x = CGFloat(UIScreen.main.bounds.size.width / 2)
        self.center.y = CGFloat(UIScreen.main.bounds.size.height * 0.75)
        self.frame.origin.y = CGFloat(385)
        self.frame.size.height = self.frame.size.height / 10
        self.frame.size.width = self.frame.size.width / 10
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

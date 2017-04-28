

import Foundation
import UIKit

class AutoFahrer: UIImageView {
    
    var autoImg2 = UIImage (named: "auto2.gif")
    var timer: Timer?
    var initialSpeed: Double = 0.05
    
    let screenWidthGlobal = Double(UIScreen.main.bounds.size.width)
    
    init(){
        super.init(image: autoImg2)
        self.center.y = CGFloat((drand48() * -(Double(UIScreen.main.bounds.size.height))))
        self.center.x = CGFloat(drand48() * screenWidthGlobal)
        self.frame.size.height = self.frame.size.height / 10
        self.frame.size.width = self.frame.size.width / 10
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveImage(){
        self.center.y += 12.5
        if self.frame.origin.y >= UIScreen.main.bounds.size.height
        {
            self.center.y = -50.0
            self.center.x = CGFloat(drand48() * Double(UIScreen.main.bounds.size.width))
        }
        
    }
    
}

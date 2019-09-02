//
//  CommonView.swift
//  Alarm
//
//  Created by 이덕화 on 30/08/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class CommonView: UIView {
    //try
    
    let identifier = "CommonView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization(name: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization(name: identifier)
    }
    
    func commonInitialization(name: String) {
        if let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }

}

extension UIView {
    
    func bottomRounded() {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func topRounded() {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight, .topLeft],
                                     cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

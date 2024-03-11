//
//  CharImageView.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit

class CharImageView: UIView {
    var imageView = UIImageView()
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    init(iconName: String) {
        super.init(frame: CGRect.zero)
    
        backgroundColor = .clear
        clipsToBounds = false
    
        imageView.image = UIImage(named: iconName)
        addSubview(imageView)
    }
  
    func updateSize() {
        imageView.frame = CGRect(x: 0, y: 0, width: 139, height: 139)
    
        let radius = radiusToSurroundFrame(imageView.frame)
        frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
    
        imageView.center = center
    
        let padding: CGFloat = 8.0
        center = CGPoint(x: center.x + imageView.frame.origin.x - padding, y: center.y - imageView.frame.origin.y + padding)
    }
  
  // calculates the radius of the circle that surrounds the label
    func radiusToSurroundFrame(_ frame: CGRect) -> CGFloat {
        return max(frame.width, frame.height) * 0.5 + 20.0
    }
  
    func curvePathWithOrigin(_ origin: CGPoint) -> UIBezierPath {
        return UIBezierPath(roundedRect: self.frame, cornerRadius: radiusToSurroundFrame(self.frame))

    }
}


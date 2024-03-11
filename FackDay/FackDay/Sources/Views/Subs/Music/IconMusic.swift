//
//  IconMusic.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit
import SnapKit
import MTSDK

class IconMusicView: UIView {
    init(_ duration: TimeInterval) {
        super.init(frame: .zero)
        self.duration = duration
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var duration: TimeInterval!
    var backgroudImage: UIImageView!
    var durationLabel: UILabel!
    
}


extension IconMusicView {
    private func setupView() {
        self.backgroundColor = .clear
        
        backgroudImage = UIImageView()
        backgroudImage >>> self >>> {
            $0.snp.makeConstraints {
                $0.trailing.bottom.leading.top.equalToSuperview()
            }
            $0.image = UIImage(named: "ic_music")
        }
        
        let min = NSInteger(duration / 60) % 60
        let sec = NSInteger(duration) % 60
        
        var minString = "\(min)"
        if min < 10 {
          minString = "0\(min)"
        }
        
        var secString = "\(sec)"
        if sec < 10 {
            secString = "0\(sec)"
        }
        
        
        durationLabel = UILabel()
        durationLabel >>> self >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(5)
                $0.bottom.trailing.equalToSuperview().offset(-5)
            }
            $0.textColor = Color.normal
            $0.text = "\(minString):\(secString)"
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 10)
        }
    }
    
    func updateDuration(_ duration: TimeInterval) {
        self.duration = duration
        
        let min = NSInteger(duration / 60) % 60
        let sec = NSInteger(duration) % 60
        
        var minString = "\(min)"
        if min < 10 {
          minString = "0\(min)"
        }
        
        var secString = "\(sec)"
        if sec < 10 {
            secString = "0\(sec)"
        }
        
        self.durationLabel.text = "\(minString):\(secString)"
    }
    
    func setHighlight() {
        self.durationLabel.textColor = Color.cusGreen
        self.backgroudImage.image = UIImage(named: "ic_music_select")
    }
    
    func setNormal() {
        self.durationLabel.textColor = Color.normal
        self.backgroudImage.image = UIImage(named: "ic_music")
    }
}

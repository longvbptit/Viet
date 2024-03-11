//
//  MainCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit
import MTSDK
import SnapKit

class MainCell: UIView {
    init(imageName: String, handle: @escaping ()->()) {
        super.init(frame: .zero)
        self.handle = handle
        self.imageName = imageName
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageName: String!
    var handle: (()->())?
    
    func setupView() {
        self.backgroundColor = .clear
        
        let imageView = UIImageView()
        imageView >>> self >>> {
            $0.snp.makeConstraints {
                $0.bottom.top.trailing.leading.equalToSuperview()
            }
            $0.image = UIImage(named: imageName)
        }
        
        let goButton = UIButton()
        goButton >>> self >>> {
            $0.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-Padding.bottom)
                $0.trailing.equalToSuperview().offset(-Padding.bottom)
                $0.width.equalTo(imageView.snp.width).multipliedBy(0.2)
                $0.height.equalTo(goButton.snp.width).multipliedBy(0.467)
            }
            $0.setImage(UIImage(named: "bt_go"), for: .normal)
            $0.handle {
                if self.handle != nil {
                    self.handle!()
                }
            }
        }
        
    }
}

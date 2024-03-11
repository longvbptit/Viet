//
//  WallPapersCollectionViewCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK

class WallPapersCollectionViewCell: UICollectionViewCell {
    var backgroundImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WallPapersCollectionViewCell {
    
    private func setupView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 8
        
        if backgroundImage == nil {
            backgroundImage = UIImageView()
            backgroundImage >>> contentView >>> {
                $0.snp.makeConstraints {
                    $0.leading.top.equalToSuperview().offset(1)
                    $0.trailing.bottom.equalToSuperview().offset(-1)
                }
                $0.layer.masksToBounds = true
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 8
                $0.layer.borderColor = Color.cusGreen.cgColor
                $0.contentMode = .scaleToFill
            }
        }
    }
    
    func configsCell(_ imageName: String) {
        self.backgroundImage.image = UIImage(named: imageName)
    }
}


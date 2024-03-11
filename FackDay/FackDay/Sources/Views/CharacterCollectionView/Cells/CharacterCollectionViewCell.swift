//
//  CharacterCollectionViewCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK

class CharacterCollectionViewCell: UICollectionViewCell {
    var backgroundImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharacterCollectionViewCell {
    
    private func setupView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = Color.cusGray
        self.contentView.layer.cornerRadius = 5
        
        
        if backgroundImage == nil {
            backgroundImage = UIImageView()
            backgroundImage >>> contentView >>> {
                $0.snp.makeConstraints {
                    $0.leading.top.equalToSuperview().offset(2)
                    $0.trailing.bottom.equalToSuperview().offset(-2)
                }
                $0.layer.masksToBounds = true
                $0.layer.borderColor = Color.cusGreen.cgColor
                $0.layer.borderWidth = 2.0
                $0.layer.cornerRadius = 5
                $0.contentMode = .scaleToFill
            }
        }
    }
    
    func configsCell(_ imageName: String, isSelected: Bool) {
        self.backgroundImage.image = UIImage(named: imageName)
        self.backgroundImage.layer.borderWidth = isSelected ? 1 : 0
    }
}

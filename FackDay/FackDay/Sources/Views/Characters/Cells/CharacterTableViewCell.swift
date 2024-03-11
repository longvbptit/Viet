//
//  CharacterTableViewCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK
import SnapKit

class CharacterTableViewCell: UITableViewCell {

    
    var iconCharacter: UIImageView!
    var nameCharacter: UILabel!
    var nextImage: UIImageView!
    private var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CharacterTableViewCell {
    func configsView(iconName: String, charactername: String) {
        if iconCharacter == nil {
            self.setupView(iconName: iconName, charactername: charactername)
        } else {
            self.iconCharacter.image = UIImage(named: iconName)
            self.nameCharacter.text = charactername
        }
        
    }

    private func setupView(iconName: String, charactername: String) {
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView = UIView()
        self.containerView >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.top.equalToSuperview().offset(5)
                $0.bottom.equalToSuperview().offset(-5)
            }
            $0.layer.cornerRadius = 8
            $0.backgroundColor = Color.cusGray
        }
        
        iconCharacter = UIImageView()
        iconCharacter >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(32)
            }
            $0.image = UIImage(named: iconName)
        }
        
        nextImage = UIImageView()
        nextImage >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(25)
            }
            $0.image = UIImage(named: "ic_next")
        }
        
        nameCharacter = UILabel()
        nameCharacter >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalTo(iconCharacter.snp.trailing).offset(Padding.leading)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(nextImage.snp.leading).offset(-Padding.trailing)
            }
            $0.adjustsFontSizeToFitWidth = true
            $0.font = Font.medium
            $0.textColor = Color.normal
            $0.text = charactername
        }
    }
}

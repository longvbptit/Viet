//
//  HomeScreenCVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK
import SnapKit

struct IconModel {
    var name: String
    var image: UIImage
    
    init(name: String, imageName: String) {
        self.name = name
        self.image = UIImage(named: imageName)!
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}



class HomeScreenCVC: UICollectionViewCell {
    var iconImageView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeScreenCVC {
    private func setupView() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        var size: CGFloat = 120
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = 152
        }
        
        iconImageView = UIImageView()
        iconImageView >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.top.leading.greaterThanOrEqualToSuperview().offset(Padding.leading)
                $0.trailing.greaterThanOrEqualToSuperview().offset(-Padding.trailing)
                $0.height.width.lessThanOrEqualTo(size)
                $0.width.equalTo(iconImageView.snp.height)
                
            }
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
            $0.contentMode = .scaleAspectFit
        }
        
        nameLabel = UILabel()
        nameLabel >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(iconImageView.snp.bottom)
                $0.bottom.equalToSuperview()
                $0.leading.equalToSuperview().offset(8)
                $0.trailing.equalToSuperview().offset(-8)
            }
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    }
    
    func configsView(_ icon: IconModel) {
        self.iconImageView.image = icon.image
        self.nameLabel.text = icon.name
    }
}

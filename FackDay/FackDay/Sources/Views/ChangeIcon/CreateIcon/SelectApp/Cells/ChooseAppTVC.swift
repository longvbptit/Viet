//
//  ChooseAppTVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK

class ChooseAppTVC: UITableViewCell {

    var appIconImage: UIImageView!
    var appNameLabel: UILabel!
    var checkedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configsView(app: AppModel, isChecked: Bool) {
        if appIconImage == nil {
            self.setupView(app, isChecked: isChecked)
        } else {
            self.appIconImage.image = UIImage(named: app.image_name)
            self.appNameLabel.text = app.name
            self.checkedImage.isHidden = !isChecked
        }
        
    }

    private func setupView(_ app: AppModel, isChecked: Bool) {
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        appIconImage = UIImageView()
        appIconImage >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.leading.top.equalToSuperview().offset(16)
                $0.bottom.equalToSuperview().offset(-8)
                $0.width.equalTo(appIconImage.snp.height).multipliedBy(1)
            }
            $0.clipsToBounds = true
            $0.image = UIImage(named: app.image_name)
            $0.layer.cornerRadius = 8
        }
        
        checkedImage = UIImageView()
        checkedImage >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.trailing.bottom.equalToSuperview().offset(-8)
                $0.width.equalTo(checkedImage.snp.height).multipliedBy(1)
            }
            $0.image = UIImage(named: "ic_tick")
            $0.isHidden = !isChecked
        }
        
        appNameLabel = UILabel()
        appNameLabel >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalTo(appIconImage.snp.trailing).offset(Padding.leading)
                $0.trailing.equalTo(checkedImage.snp.leading).offset(-Padding.trailing)
                $0.centerY.equalToSuperview()
            }
            $0.text = app.name
            $0.font = Font.small
            $0.textColor = Color.normal
        }
        
        let lineView = UIView()
        lineView >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalTo(appIconImage.snp.leading)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(1)
                $0.bottom.equalToSuperview().offset(-1)
            }
            $0.backgroundColor = .lightGray
        }
    }
}

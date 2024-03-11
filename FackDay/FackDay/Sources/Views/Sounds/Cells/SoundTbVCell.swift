//
//  SoundTbVCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK
import SnapKit
import GoogleMobileAds

protocol SoundTableViewCellDelegate {
    func didSelectItemAt(_ index: Int)
}

class SoundTbVCell: UITableViewCell {

    
    var iconMusicView: IconMusicView!
    var soundNameLabel: UILabel!
    var actionButton: UIButton!
    var progressBar: UIProgressView!
    private var containerView: UIView!
    var delegate: SoundTableViewCellDelegate?
    var timer: Timer?
    var currentProgress = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}


extension SoundTbVCell {
    func configsView(soundInfo: SoundInfo, isSelected: Bool = false) {
        self.timer?.invalidate()
        self.timer = nil
        if iconMusicView == nil {
            self.setupView(soundInfo: soundInfo, isSelected: isSelected)
        } else {
            self.iconMusicView.updateDuration(soundInfo.duration)
            self.soundNameLabel.text = soundInfo.name
            if isSelected {
                self.iconMusicView.setHighlight()
                self.progressBar.isHidden = false
                self.actionButton.setImage(UIImage(named: "ic_playmusic"), for: .normal)
                
                let maxProgress = soundInfo.duration
                self.currentProgress = SoundManager.shared.getCurrentProgress()
                self.iconMusicView.updateDuration(soundInfo.duration - self.currentProgress)
                self.progressBar.progress = Float(self.currentProgress / maxProgress)
                
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    self.currentProgress = SoundManager.shared.getCurrentProgress()
                    self.iconMusicView.updateDuration(soundInfo.duration - self.currentProgress)
                    self.progressBar.progress = Float(self.currentProgress / maxProgress)
                    print(self.currentProgress)
                    if self.currentProgress + 1 >= maxProgress {
                        self.delegate?.didSelectItemAt(self.tag)
                        timer.invalidate()
                    }
                    
                    if self.currentProgress == -1 {
                        timer.invalidate()
                    }
                })
                
            } else {
                self.iconMusicView.setNormal()
                self.progressBar.isHidden = true
                self.actionButton.setImage(UIImage(named: "ic_pause_music"), for: .normal)
                self.progressBar.progress = 0.0

            }
            
        }
    }

    private func setupView(soundInfo: SoundInfo, isSelected: Bool = false) {
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView = UIView()
        self.containerView >>> contentView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading / 2)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.top.equalToSuperview().offset(3)
                $0.bottom.equalToSuperview().offset(-3)
            }
            $0.backgroundColor = Color.backgroundColor
        }
        
        iconMusicView = IconMusicView(soundInfo.duration)
        iconMusicView >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(46)
            }
        }
        
        actionButton = UIButton()
        actionButton >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.trailing / 2)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(45)
            }
            $0.setImage(UIImage(named: "ic_pause_music"), for: .normal)
            $0.handle {
                self.delegate?.didSelectItemAt(self.tag)
            }
        }
        
        progressBar = UIProgressView()
        progressBar >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalTo(iconMusicView.snp.trailing).offset(Padding.leading)
                $0.bottom.equalTo(iconMusicView.snp.bottom).offset(-2)
                $0.height.equalTo(3)
                $0.trailing.equalTo(actionButton.snp.leading).offset(-Padding.trailing)
            }
            $0.tintColor = Color.cusGreen
            $0.isHidden = true
            $0.progress = 0.0
        }
        
        soundNameLabel = UILabel()
        soundNameLabel >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.bottom.equalTo(progressBar.snp.top).offset(-5)
                $0.leading.equalTo(progressBar.snp.leading)
                $0.trailing.equalTo(progressBar.snp.trailing)
            }
            $0.text = soundInfo.name
            $0.textColor = Color.normal
            $0.font = Font.medium
        }
    }
    
}

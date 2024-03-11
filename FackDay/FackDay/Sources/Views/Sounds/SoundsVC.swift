//
//  SoundsVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK
import GoogleMobileAds

class SoundsVC: UIViewController {
    
    var titleLabel: UILabel!
    var tableView: UITableView!
    
    let sounds: [SoundInfo] = SoundManager.shared.sounds
    var selectedIndex: Int = -1
    var tempIndex: Int = -1
}


//MARK: Lifecycle
extension SoundsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        GGAdmob.shared.loadInterstitial()
        self.registerNotification()
        self.setupView()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SoundManager.shared.stopSound()
        self.selectedIndex = -1
        self.tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

//MARK: Functions
extension SoundsVC {
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissAds), name: .interstitialDidDismiss, object: nil)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didDismissAds() {
        if self.tempIndex == -1 {return}
        self.selectedIndex = self.tempIndex
        
        let soundInfo = sounds[self.tempIndex]
        SoundManager.shared.playsound(soundInfo.filename)
        self.tableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = Color.backgroundColor
        
        let bgImageView = UIImageView()
        bgImageView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            $0.image = UIImage(named: "img_bg")
            $0.contentMode = .scaleAspectFill
        }
        
        titleLabel = UILabel()
        titleLabel >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.topSafe()).offset(Padding.top)
                $0.centerX.equalToSuperview()
            }
            $0.font = Font.title
            $0.text = "sounds".uppercased()
            $0.textColor = Color.normal
        }
        
        let backButton = UIButton()
        backButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.centerY.equalTo(titleLabel)
                $0.width.height.equalTo(32)
            }
            $0.setImage(UIImage(named: "ic_back_white"), for: .normal)
            $0.handle {
                self.removeNotification()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        let bannerView = GADBannerView()
        bannerView >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
                $0.bottom.equalTo(botSafe())
            }
            $0.adUnitID = GoogleAds.bannerAdUnitID
            $0.rootViewController = self
        }
        let request = GADRequest()
        bannerView.load(request)
        
        
        tableView = UITableView()
        tableView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top * 2)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(bannerView.snp.top)
            }
            $0.backgroundColor = .clear
            $0.register(SoundTbVCell.self, forCellReuseIdentifier: String(describing: SoundTbVCell.self))
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
        }
        
    }
    
}

extension SoundsVC: UITableViewDelegate, UITableViewDataSource, SoundTableViewCellDelegate {
    func didSelectItemAt(_ index: Int) {
        SoundManager.shared.stopSound()
        
        if self.selectedIndex == index {
            self.selectedIndex = -1
            self.tableView.reloadData()
        } else {
            self.selectedIndex = index
            self.tempIndex = index
            if GGAdmob.shared.canShowAd() {
                GGAdmob.shared.showInterstitial()
            } else {
                GGAdmob.shared.loadInterstitial()
                let soundInfo = sounds[index]
                SoundManager.shared.playsound(soundInfo.filename)
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SoundTbVCell.self), for: indexPath) as! SoundTbVCell
        
        let sound = self.sounds[indexPath.row]
        let isSelected = indexPath.row == self.selectedIndex
        cell.configsView(soundInfo: sound, isSelected: isSelected)
        cell.tag = indexPath.row
        
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
}

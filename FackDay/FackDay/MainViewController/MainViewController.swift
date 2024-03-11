//
//  MainViewController.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK
import GoogleMobileAds

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GGAdmob.shared.loadInterstitial()
        
        let backgroundImage = UIImageView()
        backgroundImage >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            $0.image = UIImage(named: "img_bg")
            $0.contentMode = .scaleAspectFill
        }
        
        let titleLabel = UILabel()
        titleLabel >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.top.equalTo(topSafe()).offset(Padding.top / 2)
                $0.height.equalTo(50)
            }
            $0.text = "FANS ART"
            $0.textColor = Color.title
            $0.font = Font.mainTitle
        }
        
        let rateButton = UIButton()
        rateButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.centerY.equalTo(titleLabel)
                $0.width.height.equalTo(39)
            }
            $0.contentHorizontalAlignment = .fill
            $0.contentVerticalAlignment = .fill
            $0.setImage(UIImage(named: "ic_rate"), for: .normal)
            $0.handle {
                self.openURL(AppConfigs.rateAppURL)
            }
        }
        
        let scrollView = UIScrollView()
        scrollView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top)
                $0.bottom.equalTo(botSafe()).offset(-50)
                $0.leading.trailing.equalToSuperview()
            }
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
        }
        
        let containerView = UIView()
        containerView >>> scrollView >>> {
            $0.snp.makeConstraints {
                $0.left.right.equalTo(self.view)
                $0.bottom.top.equalTo(scrollView)
            }
            $0.backgroundColor = .clear
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
        
        let makerIconButton = MainCell(imageName: "bt_makericon", handle: {
            GGAdmob.shared.showInterstitial()
            let makerVC = ChangeIconVC()
            self.navigationController?.pushViewController(makerVC, animated: true)
        })
        makerIconButton >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(makerIconButton.snp.width).multipliedBy(0.59)
            }
        }
        
        
        let wallPaperButton = MainCell(imageName: "bt_wallpaper", handle: {
            GGAdmob.shared.showInterstitial()
            let wallVC = WallPapersVC()
            self.navigationController?.pushViewController(wallVC, animated: true)
        })
        wallPaperButton >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(makerIconButton.snp.bottom).offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(makerIconButton.snp.width).multipliedBy(0.77)
            }
        }
        
        let charButton = MainCell(imageName: "bt_characters", handle: {
            GGAdmob.shared.showInterstitial()
            let charVC = CharactersVC()
            self.navigationController?.pushViewController(charVC, animated: true)
        })
        charButton >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(wallPaperButton.snp.bottom).offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(makerIconButton.snp.width).multipliedBy(0.59)
            }
        }
        
        let soundButton = MainCell(imageName: "bt_sound", handle: {
            GGAdmob.shared.showInterstitial()
            let soundVC = SoundsVC()
            self.navigationController?.pushViewController(soundVC, animated: true)
        })
        soundButton >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(charButton.snp.bottom).offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(makerIconButton.snp.width).multipliedBy(0.59)
                $0.bottom.equalToSuperview().offset(-Padding.bottom)
            }
        }
        
        //
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override var prefersStatusBarHidden: Bool {return true}
}

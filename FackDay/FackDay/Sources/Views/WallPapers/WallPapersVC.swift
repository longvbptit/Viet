//
//  WallPapersVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import GoogleMobileAds
import MTSDK

class WallPapersVC: UIViewController {

    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var imageNames: [String]!
}

//MARK: Life cycles
extension WallPapersVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.setupView()
        
        GGAdmob.shared.loadInterstitial()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool { return true }

}

//MARK: Functions
extension WallPapersVC {
    func fetchData() {
        self.imageNames = []
        for index in 1...23 {
            let img = "\(index)_wall"
            self.imageNames.append(img)
        }
    }
    
    func setupView() {
        view.backgroundColor = .black
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
            $0.text = "wallpaper".uppercased()
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
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.collectionView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top)
                $0.bottom.equalTo(bannerView.snp.top)
                $0.leading.trailing.equalToSuperview()
            }
            $0.register(WallPapersCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: WallPapersCollectionViewCell.self))
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
        }
    }
}

extension WallPapersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WallPapersCollectionViewCell.self), for: indexPath) as! WallPapersCollectionViewCell
        
        cell.configsCell(imageNames[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewVC = PreviewWallpaperVC(imageNames[indexPath.item])
        previewVC.modalPresentationStyle = .fullScreen
        self.present(previewVC, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - (16 * 3)) / 2
        
        return CGSize(width: width, height: width * 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

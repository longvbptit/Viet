//
//  PreviewHomeScreenVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK
import SnapKit

protocol PreviewHomeScreenDelegate {
    func previewDidDisappear()
}

class PreviewHomeScreenVC: UIViewController {

    init(_ image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.yourAppIcon = IconModel(name: "Your App", image: image)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    var delegate: PreviewHomeScreenDelegate?
    var yourAppIcon: IconModel!
    
    var collectionView: UICollectionView!
    var items: [IconModel] =  [IconModel(name: "Weather", imageName: "62_weather_apple.png"), IconModel(name: "Settings", imageName: "31_ic_settings_apple.png"), IconModel(name: "Camera", imageName: "40_ic_camera_apple.png"), IconModel(name: "Calendar", imageName: "53_calendar_apple.png"), IconModel(name: "Maps", imageName: "57_maps_apple.png"), IconModel(name: "Notes", imageName: "38_ic_notes_apple.png"), IconModel(name: "News", imageName: "58_news_apple.png"), IconModel(name: "Music", imageName: "29_ic_music_apple.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        items.append(self.yourAppIcon)
        self.setupView()
        GGAdmob.shared.loadInterstitial()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.previewDidDisappear()
    }

}

extension PreviewHomeScreenVC {
    func setupView() {
        let background = UIImageView()
        background >>> view >>> {
            $0.snp.makeConstraints {
                $0.bottom.top.trailing.leading.equalToSuperview()
            }
            $0.image = UIImage(named: "wall_ios_14")
            $0.contentMode = .scaleAspectFill
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        let width = (view.bounds.size.width - (8 * 5)) / 4
        layout.itemSize = CGSize(width: width, height: width + 20)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(Padding.top * 3)
                $0.bottom.trailing.leading.equalToSuperview()
            }
            $0.register(HomeScreenCVC.self, forCellWithReuseIdentifier: String(describing: HomeScreenCVC.self))
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
        
    }
}

extension PreviewHomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeScreenCVC.self), for: indexPath) as! HomeScreenCVC
        cell.configsView(self.items[indexPath.item])
        
        return cell
    }
    
    
}

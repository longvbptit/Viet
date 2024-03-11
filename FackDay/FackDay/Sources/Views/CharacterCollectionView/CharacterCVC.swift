//
//  CharacterCVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK

class CharacterCVC: UIViewController {

    init(_ type: ChangerIconType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        self.loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Variables
    var selectedIndex: Int = 0 {
        didSet {
            if collectionView != nil {
                collectionView.reloadData()
            }
            
            if self.actionHandle != nil {
                self.actionHandle!(self.type, images[selectedIndex])
            }
        }
    }
    private var type: ChangerIconType!
    private var images: [String] = []
    var collectionView: UICollectionView!
    private var actionHandle: ((ChangerIconType, String) -> Void)?
}

//MARK: Life cycles
extension CharacterCVC {
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension CharacterCVC {
    
    func loadData() {
        switch self.type {
        case .background:
            images = ChangerIcon.backgrounds
            break
        case .icon:
            images = ChangerIcon.icons
            break
        case .none:
            break
        }
    }
    
    func setupView() {
        view.backgroundColor = Color.backgroundColor
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        let width = ((view.bounds.size.width - (Padding.leading * 2)) - (8 * 5)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.collectionView >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.top.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.bottom.equalToSuperview()
            }
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self))
            $0.delegate = self
            $0.dataSource = self
            
        }
    }
    
    func handle(_ handle: @escaping (ChangerIconType, String) -> Void) {
        self.actionHandle = handle
    }
    
}

extension CharacterCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCollectionViewCell.self), for: indexPath) as! CharacterCollectionViewCell
        
        cell.configsCell(images[indexPath.item], isSelected: indexPath.item == self.selectedIndex)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
    }
}


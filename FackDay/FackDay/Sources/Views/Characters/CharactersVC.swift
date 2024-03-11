//
//  CharactersVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK
import GoogleMobileAds

class CharactersVC: UIViewController {
    
    var titleLabel: UILabel!
    var tableView: UITableView!
    
    let characters: [CharacterInfo] = CharacterManager.shared.characters

}


//MARK: Lifecycle
extension CharactersVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        GGAdmob.shared.loadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

//MARK: Functions
extension CharactersVC {
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
            $0.text = "characters".uppercased()
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
        
        tableView = UITableView()
        tableView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top * 2)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(bannerView.snp.top)
            }
            $0.backgroundColor = .clear
            $0.register(CharacterTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterTableViewCell.self))
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
        }
        
    }
}

extension CharactersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self), for: indexPath) as! CharacterTableViewCell
        
        let character = self.characters[indexPath.row]
        cell.configsView(iconName: character.image, charactername: character.title)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GGAdmob.shared.showInterstitial()
        let character = self.characters[indexPath.row]
        let charDetailVC = CharDetailsVC(character)
        self.navigationController?.pushViewController(charDetailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
}

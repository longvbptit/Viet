//
//  PreviewWallpaperVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK

class PreviewWallpaperVC: UIViewController {

    init(_ imageName: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageName = imageName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Variables
    var imageView: UIImageView!
    var imageName: String!
}


//MARK: Life cycles
extension PreviewWallpaperVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        GGAdmob.shared.loadInterstitial()
    }
    
    override var prefersStatusBarHidden: Bool { return true }

}

//MARK:
extension PreviewWallpaperVC {
    func setupView() {
        imageView = UIImageView()
        imageView >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.trailing.top.bottom.equalToSuperview()
            }
            $0.image = UIImage(named: imageName)
            $0.contentMode = .scaleToFill
        }
        
        let backButton = UIButton()
        backButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Padding.top)
                $0.height.width.equalTo(39)
            }
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
            $0.setImage(UIImage(named: "ic_cancel"), for: .normal)
            $0.handle {
                self.dismiss(animated: true, completion: {
                    GGAdmob.shared.showInterstitial()
                })
            }
        }
        
        let shareButton = UIButton()
        shareButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.leading)
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Padding.top)
                $0.height.width.equalTo(39)
            }
            $0.setImage(UIImage(named: "ic_share"), for: .normal)
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
            $0.handle {
                if let image: UIImage = self.imageView.image {
                    self.share(items: [image])
                }
            }
        }
        
        let saveWallpaper = UIButton()
        saveWallpaper >>> view >>> {
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Padding.bottom * 2)
                $0.height.equalTo(45)
                $0.width.equalTo(saveWallpaper.snp.height).multipliedBy(3.85)
            }
            $0.setImage(UIImage(named: "bt_download"), for: .normal)
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
            $0.handle {
                if let image: UIImage = self.imageView.image {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.showAlert(title: "Saved error", message: error.localizedDescription, completion: nil)
        } else {
            self.showAlert(title: "Saved!", message:"The image has been saved to your Photos", completion: {_ in 
                GGAdmob.shared.showInterstitial()
            })
        }
    }
}

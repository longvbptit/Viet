//
//  ChangeIconVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import SnapKit
import MTSDK
import Parchment
import GoogleMobileAds

struct PagingCharacter {
    let image: String
    let selectedImage: String
    let viewcontroler: UIViewController
}


class ChangeIconVC: UIViewController {

    var titleLabel: UILabel!
    var characterView: UIView!
    var backgroundImage: UIImageView!
    var iconImage: UIImageView!
    
    var nextButton: UIButton!
    var previewButton: UIButton!
    var selectPhotoButton: UIButton!
    var saveButton: UIButton!
    
    var bottomView: UIView!
    var pagingCharacters: [PagingCharacter] = []
    var pagingViewController: PagingViewController!
    
    let backgroundVC = CharacterCVC(.background)
    let iconVC = CharacterCVC(.icon)
    
    var tempImage: UIImage!
    
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

extension ChangeIconVC {
    
    func setupView() {
        self.view.backgroundColor = Color.backgroundColor
        
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
            $0.text = "changer icon".uppercased()
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
        
        nextButton = UIButton()
        nextButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.centerY.equalTo(titleLabel.snp.centerY)
                $0.height.equalTo(32)
                $0.width.equalTo(nextButton.snp.height).multipliedBy(2.245)
            }
            $0.setImage(UIImage(named: "bt_next"), for: .normal)
            $0.handle {
                self.characterView.layer.cornerRadius = 0
                guard let image = self.characterView.asImage() else {
                    self.characterView.layer.cornerRadius = 8
                    return
                }
                
                self.characterView.layer.cornerRadius = 8
                self.characterView.layer.borderWidth = 1
                
                GGAdmob.shared.showInterstitial()
                let changeIconVC = CreateSkinIconVC(image)
                changeIconVC.delegate = self
                self.navigationController?.pushViewController(changeIconVC, animated: true)
            }
        }
        
        characterView = UIView()
        characterView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top * 2)
                $0.centerX.equalToSuperview()
                $0.width.height.equalTo(199)
            }
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        
        backgroundImage = UIImageView()
        backgroundImage >>> characterView >>> {
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.top.equalToSuperview()
            }
            $0.image = UIImage(named: ChangerIcon.backgrounds[0])
        }
        
        iconImage = UIImageView()
        iconImage >>> characterView >>> {
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.top.equalToSuperview()
            }
            $0.image = UIImage(named: ChangerIcon.icons[0])
        }
        
        selectPhotoButton = UIButton()
        selectPhotoButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.height.equalTo(39)
                $0.top.equalTo(characterView.snp.bottom).offset(Padding.top * 2)
                $0.width.equalTo(selectPhotoButton.snp.height).multipliedBy(3.79)
            }
            $0.setImage(UIImage(named: "bt_select_photo"), for: .normal)
            $0.handle {
                let pickerImage = UIImagePickerController()
                pickerImage.delegate = self
                pickerImage.mediaTypes = ["public.image"]
                pickerImage.sourceType = .photoLibrary
                self.present(pickerImage, animated: true, completion: nil)
            }
        }
        
        previewButton = UIButton()
        previewButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading * 2)
                $0.centerY.equalTo(selectPhotoButton)
                $0.height.width.equalTo(32)
            }
            $0.setImage(UIImage(named: "ic_view"), for: .normal)
            $0.handle {
                self.characterView.layer.cornerRadius = 0
                guard let image = self.characterView.asImage() else {
                    self.characterView.layer.cornerRadius = 8
                    return
                }
                self.characterView.layer.cornerRadius = 8
                
                let previewVC = PreviewHomeScreenVC(image)
                previewVC.delegate = self
                self.present(previewVC, animated: true, completion: nil)
                
            }
        }
        
        saveButton = UIButton()
        saveButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-Padding.leading * 2)
                $0.centerY.equalTo(selectPhotoButton)
                $0.height.width.equalTo(32)
            }
            $0.setImage(UIImage(named: "ic_download"), for: .normal)
            $0.handle {
                self.characterView.layer.cornerRadius = 0
                guard let image = self.characterView.asImage() else {
                    self.characterView.layer.cornerRadius = 8
                    return
                }
                self.characterView.layer.cornerRadius = 8
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
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
        
        bottomView = UIView()
        bottomView >>> view >>> {
            $0.snp.makeConstraints {
                $0.bottom.equalTo(bannerView.snp.top)
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(saveButton.snp.bottom).offset(Padding.top * 2)
            }
            $0.backgroundColor = Color.backgroundColor
        }
        
        self.setupPaging()
        
        //
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
    
    func setupPaging() {
        backgroundVC.handle { type, image in
            self.updateCharacter(type: type, image: image)
        }
        
        let pagingBackground = PagingCharacter(image: ChangerIconType.background.image(false), selectedImage: ChangerIconType.background.image(true), viewcontroler: backgroundVC)
        
        
        iconVC.handle { type, image in
            self.updateCharacter(type: type, image: image)
        }
        let pagingIcon = PagingCharacter(image: ChangerIconType.icon.image(false), selectedImage: ChangerIconType.icon.image(true), viewcontroler: iconVC)
        
        pagingCharacters = [pagingBackground, pagingIcon]
        pagingViewController = PagingViewController(viewControllers: pagingCharacters.map {$0.viewcontroler} )
        pagingViewController.register(IconPagingCell.self, for: IconItem.self)
        let maxSize = view.bounds.width
        let itemSize = (maxSize - (Padding.leading * 3)) / 2
        pagingViewController.menuItemSize = .sizeToFit(minWidth: itemSize, height: 69)
        pagingViewController.view.backgroundColor = .clear
        pagingViewController.backgroundColor = .clear
        pagingViewController.borderColor = .clear
        pagingViewController.indicatorColor = .clear
        pagingViewController.menuBackgroundColor = Color.cusGray
        pagingViewController.menuItemSpacing = 0
        
        addChild(pagingViewController)
        bottomView.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        pagingViewController.dataSource = self
        pagingViewController.delegate = self
        pagingViewController.select(index: 0)
        pagingViewController.view.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func updateCharacter(type: ChangerIconType, image: String) {

        switch type {
        case .background:
            self.backgroundImage.image = UIImage(named: image)
            break
        case .icon:
            self.iconImage.image = UIImage(named: image)
            break
        }
    }
}

extension ChangeIconVC: PagingViewControllerDataSource, PagingViewControllerDelegate {
  
    func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return pagingCharacters.map {$0.viewcontroler}[index]
    }
  
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return IconItem(icon: pagingCharacters.map {$0.image}[index], selectedIcon: pagingCharacters.map {$0.selectedImage}[index], index: index)
    }
  
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return pagingCharacters.count
    }
  
}

extension ChangeIconVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
            if let editedImage = info[.editedImage] as? UIImage {
                selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                selectedImage = originalImage
            } else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
        self.backgroundImage.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ChangeIconVC: PreviewHomeScreenDelegate, CreateSkinIconViewControllerDelegate {
    func previewDidDisappear() {
        GGAdmob.shared.showInterstitial()
    }
    
    func didPopToRootView() {
        //self.showRatePopup()
    }
}

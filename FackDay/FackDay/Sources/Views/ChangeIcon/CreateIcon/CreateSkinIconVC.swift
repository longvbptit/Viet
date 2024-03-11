//
//  CreateSkinIconVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//


import UIKit
import GoogleMobileAds
import SnapKit
import MTSDK

protocol CreateSkinIconViewControllerDelegate {
    func didPopToRootView()
}

class CreateSkinIconVC: UIViewController {

    init(_ icon: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.icon = icon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Variables
    var startServerTracking: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "kStartWebServerTracking")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "kStartWebServerTracking")
            UserDefaults.standard.synchronize()
        }
    }
    
    var bannerView: GADBannerView!
    var createButton: UIButton!
    var buttonChooseapp: UIButton!
    var icon: UIImage!
    var characterImage: UIImageView!
    var appicon: UIImageView!
    var appNameTextfield: UITextField!
    var appDatas: [AppModel]!
    var selectedApp: AppModel? {
        didSet {
            self.createButton.isEnabled = true
        }
    }
    var delegate: CreateSkinIconViewControllerDelegate?
    lazy var base64ImgStep1: String = {
        return Asset.imgStep1Web.image.toBase64()!
    }()
    lazy var base64ImgStep2: String = {
        return Asset.imgStep2Web.image.toBase64()!
    }()
    lazy var base64HTML: WebSite = {
        return WebSite()
    }()
    
    var countChooseApp: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Server.webServer.isRunning {
            Server.webServer.stop()
        }
        self.appDatas = loadAppDatas()
        self.setupView()
        self.hideKeyboardEvent()
        self.startServerTracking = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(reopenApp), name: .reopenAppAfterStartWebserver, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension CreateSkinIconVC {
    
    @objc func reopenApp() {
        if self.startServerTracking && Server.webServer.isRunning {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func setupView() {
        view.backgroundColor = Color.backgroundColor
        
        let backButton = UIButton()
        backButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(8)
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Padding.top)
                $0.height.width.equalTo(32)
            }
            $0.setImage(UIImage(named: "ic_back_white"), for: .normal)
            $0.handle {
                //GoogleAdMob.shared.showInterstitial()
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didPopToRootView()
            }
        }
        
        let titleLabel = UILabel()
        titleLabel >>> view >>> {
            $0.snp.makeConstraints {
                $0.centerY.equalTo(backButton.snp.centerY)
                $0.height.equalTo(32)
                $0.centerX.equalToSuperview()
            }
            $0.font = Font.title
            $0.textAlignment = .center
            $0.textColor = Color.title
            $0.text = "Change Icon".uppercased()
        }
        
        createButton = UIButton()
        createButton >>> view >>> {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-8)
                $0.centerY.equalTo(titleLabel.snp.centerY)
                $0.height.equalTo(30)
                $0.width.equalTo(createButton.snp.height).multipliedBy(2.55)
            }
            $0.isEnabled = false
            $0.setImage(UIImage(named: "bt_create"), for: .normal)
            $0.handle {

                if self.selectedApp == nil {return}
                //GoogleAdMob.shared.showInterstitial()
                self.startGCDWebServer()
                let url = URL(string: "http://localhost:8080")
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    self.startServerTracking = true
                } else {
                    print("error")
                }
            }
        }
        
        characterImage = UIImageView()
        characterImage >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top * 2)
                $0.centerX.equalToSuperview()
                $0.width.height.equalTo(199)
            }
            $0.image = icon
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.masksToBounds = true
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
        
        let scrollView = UIScrollView()
        scrollView >>> view >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(characterImage.snp.bottom).offset(Padding.top * 2)
                $0.bottom.equalTo(bannerView.snp.top)
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
        //
        
        
        let appNameLabel = UILabel()
        appNameLabel >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.height.equalTo(39)
            }
            $0.text = "App name"
            $0.textColor = Color.normal
            $0.font = Font.medium
            $0.textAlignment = .left
            
        }
        
        appNameTextfield = UITextField()
        appNameTextfield >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.top.equalTo(appNameLabel.snp.bottom).offset(Padding.top)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(50)
            }
            $0.backgroundColor = .white
            $0.attributedPlaceholder = NSAttributedString(string: "Input Text",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            $0.borderStyle = .roundedRect
            $0.clearButtonMode = .whileEditing
            $0.delegate = self
        }
        
        let selectAppLabel = UILabel()
        selectAppLabel >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(appNameTextfield.snp.bottom).offset(Padding.top * 2)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.height.equalTo(50)
            }
            $0.text = "Select your App"
            $0.textColor = Color.normal
            $0.font = Font.medium
            $0.textAlignment = .left
            
        }
        
        let selectAppView = UIView()
        selectAppView >>> containerView >>> {
            $0.snp.makeConstraints {
                $0.top.equalTo(selectAppLabel.snp.bottom).offset(Padding.top)
                $0.leading.equalToSuperview().offset(Padding.leading)
                $0.trailing.equalToSuperview().offset(-Padding.trailing)
                $0.height.equalTo(69)
                $0.bottom.equalToSuperview().offset(-Padding.bottom)
            }
            $0.backgroundColor = Color.cusGray
            $0.layer.cornerRadius = 8
            
        }
        
        appicon = UIImageView()
        appicon >>> selectAppView >>> {
            $0.snp.makeConstraints {
                $0.leading.top.equalToSuperview().offset(10)
                $0.bottom.equalToSuperview().offset(-10)
                $0.width.equalTo(appicon.snp.height).multipliedBy(1)
            }
            $0.clipsToBounds = true
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = 8
        }
        
        buttonChooseapp = UIButton()
        buttonChooseapp >>> selectAppView >>> {
            $0.snp.makeConstraints {
                $0.trailing.bottom.equalToSuperview().offset(-10)
                $0.top.equalToSuperview().offset(10)
                $0.leading.equalTo(appicon.snp.trailing).offset(16)
            }
            $0.layer.cornerRadius = 8
            $0.setTitle("Choose app to change icon", for: .normal)
            $0.titleLabel?.font = Font.normal
            $0.backgroundColor = Color.cusGreen
            $0.handle {
                let selectAppVC = SelectAppVC(apps: self.appDatas, selectedApp: self.selectedApp)
                selectAppVC.modalPresentationStyle = .fullScreen
                selectAppVC.delegate = self
                selectAppVC.didSelectApp = { [weak self] app in
                    self?.countChooseApp += 1
                    self?.selectedApp = app
                    self?.appicon.image = UIImage(named: app.image_name)
                    self?.buttonChooseapp.setTitle(app.name, for: .normal)
                    self?.checkContinue()
                }
                self.present(selectAppVC, animated: true, completion: nil)
            }
        }
        
        
        //
    }
    
    func loadAppDatas() -> [AppModel] {
        if let infoPlistPath = Bundle.main.url(forResource: "SelectApp", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                let decoder = PropertyListDecoder()
                let result = try decoder.decode([AppModel].self, from: infoPlistData)
                return result
            } catch {
                print(error)
                return []
            }
        } else {
            return []
        }
    }
    
    func startGCDWebServer() {
        let webServer = Server.webServer
        let name = self.appNameTextfield.text ?? ""
        let base64Img = self.icon.toBase64()!
        let link = self.selectedApp!.url_scheme

        let variables = [
            "image_1" : base64Img,
            "title": name,
            "urlSchemes":link,
            "img_step_1":base64ImgStep1,
            "img_step_2":base64ImgStep2,
        ]
        let strUrl = base64HTML.initHTML(dict: variables).base64Encoded
        webServer.addHandler(forMethod: "GET" , path: "/" , request: GCDWebServerRequest . self , processBlock: {(request) -> GCDWebServerResponse  in

            let url = URL (string: "data:text/html;charset=utf-8;base64," + strUrl , relativeTo: request.url)

            return  GCDWebServerDataResponse (redirect: url!, permanent: false )
        });

        //Server start
        webServer.start(withPort: 8080 , bonjourName: "GCD Web Server" )
        
    }
    
    func checkContinue() {
        guard let text = self.appNameTextfield.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.createButton.isEnabled = false
            return
        }
        
        if selectedApp == nil {
            self.createButton.isEnabled = false
            return
        }
        self.createButton.isEnabled = true
    }
}

extension CreateSkinIconVC: UITextFieldDelegate, SelectAppViewControllerDelegate {
    
    func didPopToRootView() {
        if self.countChooseApp > 1 {
            GGAdmob.shared.showInterstitial()
        } else {
            print("chua du")
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.checkContinue()
    }
}

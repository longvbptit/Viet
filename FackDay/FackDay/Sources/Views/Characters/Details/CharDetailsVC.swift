//
//  CharDetailsVC.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import MTSDK
import SnapKit
import GoogleMobileAds

class CharDetailsVC: UIViewController {

    init(_ char: CharacterInfo) {
        super.init(nibName: nil, bundle: nil)
        self.charInfo = char
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    var titleLabel: UILabel!
    var charInfo: CharacterInfo!
    var textView: UITextView!
    var textStorage: SyntaxHighlightTextStorage!
    var imageView: CharImageView!
    var bannerView: GADBannerView!
    
}

//Mark: Lifecycle
extension CharDetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        updateTimeIndicatorFrame()
        textStorage.update()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//MARK: Functions
extension CharDetailsVC {
    
    func setupView() {
        view.backgroundColor = Color.backgroundColor
        
        let backButton = UIButton()
        backButton >>> view >>>  {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.topSafe())
                $0.leading.equalToSuperview().offset(Padding.leading / 2)
                $0.height.width.equalTo(32)
            }
            $0.setImage(UIImage(named: "ic_back_white"), for: .normal)
            $0.handle {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        titleLabel = UILabel()
        titleLabel >>> view >>> {
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalTo(backButton.snp.centerY)
            }
            $0.font = Font.title
            $0.textColor = Color.normal
            $0.text = charInfo.title
        }
        
        bannerView = GADBannerView()
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
        
        createTextView()
        textView.isScrollEnabled = true
        textView.adjustsFontForContentSizeCategory = true
        imageView = CharImageView(iconName: charInfo.image)
        textView.addSubview(imageView)
    }
    
    func createTextView() {
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: charInfo.details, attributes: attrs)
        textStorage = SyntaxHighlightTextStorage()
        textStorage.append(attrString)
      
        let newTextViewRect = view.bounds
      
        let layoutManager = NSLayoutManager()
      
        let containerSize = CGSize(width: newTextViewRect.width, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
    
        
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.backgroundColor = .clear
        textView.font = Font.small
        textView.textColor = Color.normal
        textView.isEditable =  false
        view.addSubview(textView)
    
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Padding.leading)
            $0.trailing.equalToSuperview().offset(-Padding.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.top * 3)
            $0.bottom.equalTo(bannerView.snp.top)
        }
    }
    
    func updateTimeIndicatorFrame() {
        imageView.updateSize()
        imageView.frame = imageView.frame.offsetBy(dx: textView.frame.width - imageView.frame.width + 20, dy: 0)
        let exclusionPath = imageView.curvePathWithOrigin(imageView.center)
        textView.textContainer.exclusionPaths = [exclusionPath]
    }
}



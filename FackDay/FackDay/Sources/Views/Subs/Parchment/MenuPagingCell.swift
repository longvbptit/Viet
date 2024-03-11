//
//  MenuPagingCell.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit
import Parchment
import SnapKit

struct IconPagingCellViewModel {
    let image: String
    let selectedImage: String
    let selected: Bool
    
  
    init(image: String, selectedImage: String ,selected: Bool, options: PagingOptions) {
        self.image = image
        self.selectedImage = selectedImage
        self.selected = selected
    }
}

class IconPagingCell: PagingCell {
  
    fileprivate var viewModel: IconPagingCellViewModel?
  
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(containerView)
    containerView.addSubview(imageView)
    self.backgroundColor = .clear
    contentView.backgroundColor = .clear
    
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
    if let item = pagingItem as? IconItem {

      let viewModel = IconPagingCellViewModel(
        image: item.icon,
        selectedImage: item.selectedIcon,
        selected: selected,
        options: options)
      
        let imageName = selected ? viewModel.selectedImage : viewModel.image
        self.imageView.image = UIImage(named: imageName)
      
        self.viewModel = viewModel
    }
  }
  
  open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {}
  
  private func setupConstraints() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.snp.makeConstraints {
        $0.top.leading.equalToSuperview().offset(8)
        $0.bottom.trailing.equalToSuperview().offset(-8)
    }
    containerView.backgroundColor = Color.cusGray
    
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.snp.makeConstraints {
        $0.leading.equalToSuperview().offset(Padding.leading / 2)
        $0.trailing.equalToSuperview().offset(-Padding.leading / 2)
        $0.height.equalTo(imageView.snp.width).multipliedBy(0.218)
        $0.centerY.equalToSuperview()
    }
  }
  
}


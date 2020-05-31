//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            imageView.image = viewModel.userImage
            nameView.text = viewModel.textLabelText
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 40
        nameView.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        nameView.tintColor = .black
    
    }
    
    private func animate(){
        let squarePath = UIBezierPath(rect: imageView.bounds).cgPath
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = squarePath
        shapeLayer.fillColor = .init(srgbRed: 50, green: 50, blue: 50, alpha: 0.6)
        shapeLayer.contents = imageView.image
        imageView.layer.addSublayer(shapeLayer)

        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.fromValue = squarePath
        let circlePath = UIBezierPath(ovalIn: imageView.bounds).cgPath
        morphAnimation.toValue = circlePath
        morphAnimation.duration = 1.0

        shapeLayer.speed = 0.6
        shapeLayer.add(morphAnimation, forKey: "morphAnimation")
        
        shapeLayer.path = .none
    }
    
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        imageView?.image = viewModel?.userImage
        animate()
        setNeedsLayout()
    }
}

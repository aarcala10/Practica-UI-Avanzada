//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var postersNum: UILabel!
    @IBOutlet weak var datePost: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            viewModel.fetchUserAvatar(viewModel.username)
            topicTitle.text = viewModel.textLabelText
            avatarUser.image = viewModel.avatarUser
            postCount.text = "\(viewModel.postCount)"
            postersNum.text = "\(viewModel.postersNum)"
            datePost.text = viewModel.dateFormated
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarUser.layer.cornerRadius = 32
        postCount.tintColor = .black
        postersNum.tintColor = .black
        datePost.tintColor = .black
        topicTitle.tintColor = .black
        topicTitle.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        postCount.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        postersNum.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        datePost.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        
    }
    
    private func animate(){
        let shapeLayer = CAShapeLayer()
        let squarePath = UIBezierPath(rect: avatarUser.bounds).cgPath
        shapeLayer.path = squarePath
        shapeLayer.fillColor = .init(srgbRed: 50, green: 50, blue: 50, alpha: 0.6)
        shapeLayer.contents = avatarUser.image
        avatarUser.layer.addSublayer(shapeLayer)

        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.fromValue = squarePath
        let circlePath = UIBezierPath(ovalIn: avatarUser.bounds).cgPath
        morphAnimation.toValue = circlePath
        morphAnimation.duration = 1.0

        shapeLayer.speed = 0.6
        shapeLayer.add(morphAnimation, forKey: "morphAnimation")
        
        shapeLayer.path = .none
    }
    
}
extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        avatarUser.image = viewModel?.avatarUser
        animate()
        setNeedsLayout()
    }
}

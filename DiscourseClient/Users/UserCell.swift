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
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        imageView?.image = viewModel?.userImage
        setNeedsLayout()
    }
}

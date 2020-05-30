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
        topicTitle.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        postCount.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        postersNum.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        datePost.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        
    }
    
}
extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        avatarUser.image = viewModel?.avatarUser
        
        setNeedsLayout()
    }
}

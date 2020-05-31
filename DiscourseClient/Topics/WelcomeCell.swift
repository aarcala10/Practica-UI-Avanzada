//
//  WelcomeCell.swift
//  DiscourseClient
//
//  Created by Adrian Arcalá Ocón on 29/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {

    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var viewModel: WelcomeCellViewModel? {
    didSet {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.titleLabel
        labelDescription.text = viewModel.descriptionLabel
        titleLabel.tintColor = .black
        labelDescription.tintColor = .black
        
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLabel.layer.cornerRadius = 8
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        labelDescription.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
}

//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
protocol TopicCellViewModelViewDelegate: class {
    func userImageFetched()
}
/// ViewModel que representa un topic en la lista
class TopicCellViewModel: CellViewModel {
    weak var viewDelegate: TopicCellViewModelViewDelegate?
    weak var topicsViewDelegate: TopicsViewDelegate?
    let topic: Topic
    let userDataManager: UserDataManager
    var textLabelText: String
    var postCount: Int
    var postersNum: Int
    var avatarUser: UIImage?
    var datePost: String
    var username: String
    var dateFormated: String
    
    
    
    init(topic: Topic, dataManager: UserDataManager) {
        self.topic = topic
        self.userDataManager = dataManager
        textLabelText = topic.title
        dateFormated = ""
        
        postCount = topic.postsCount
        postersNum = topic.posters.count
        datePost = topic.lastPostedAt
        username = topic.lastPosterUsername
        
        let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: datePost) else {return}
        
        let outputFormat = "d MMM"
        dateFormatter.dateFormat = outputFormat
        let outputStringDate = dateFormatter.string(from: date)
        dateFormated = outputStringDate.capitalized
    }
    
    func fetchUserAvatar(_ username: String){
        
        //Condicional para no saturar API con peticiones de Red
        if avatarUser == nil {
        userDataManager.fetchUser(username: username) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }
                
                let avatarUserString = response.user.avatarTemplate
                
                var imageStringURL = "https://mdiscourse.keepcoding.io"
                imageStringURL.append(avatarUserString.replacingOccurrences(of: "{size}", with: "64"))
                DispatchQueue.global(qos: .userInitiated).async { 
                    if let url = URL(string: imageStringURL), let data = try? Data(contentsOf: url) {
                        self?.avatarUser = UIImage(data: data)
                        DispatchQueue.main.async {
                            self?.viewDelegate?.userImageFetched()
                        }
                    }
                }
            case .failure:
                DispatchQueue.main.async {
 
                self?.avatarUser = UIImage.init(named: "person")
                self?.viewDelegate?.userImageFetched()
                }
            }
            }
        }
    }
}

    

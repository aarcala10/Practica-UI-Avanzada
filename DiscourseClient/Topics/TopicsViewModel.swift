//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
    func userImageFetched()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    let userDataManager: UserDataManager
    var topicsViewModels: [TopicCellViewModel] = []
    var cellViewModels: [CellViewModel] = []

    init(topicsDataManager: TopicsDataManager, userDataManager: UserDataManager) {
        self.topicsDataManager = topicsDataManager
        self.userDataManager = userDataManager
    }

    fileprivate func fetchTopicsAndReloadUI() {
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }
                self?.topicsViewModels = response.topicList.topics.map({ TopicCellViewModel(topic: $0, dataManager: self!.userDataManager) })
                
                self?.cellViewModels = response.topicList.topics.map({ TopicCellViewModel(topic: $0, dataManager: self!.userDataManager) })
                
                self?.cellViewModels.insert(WelcomeCellViewModel(), at: 0)
                self?.viewDelegate?.topicsFetched()
                
            case .failure:
                self?.viewDelegate?.errorFetchingTopics()
            }
        }
    }

    func viewWasLoaded() {
        fetchTopicsAndReloadUI()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return cellViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.row < cellViewModels.count else { return nil }
        return cellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < cellViewModels.count else { return }
        if indexPath.row > 0{
        coordinatorDelegate?.didSelect(topic: topicsViewModels[indexPath.row - 1].topic)
        }
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        fetchTopicsAndReloadUI()
    }

    func topicWasDeleted() {
        fetchTopicsAndReloadUI()
    }
}

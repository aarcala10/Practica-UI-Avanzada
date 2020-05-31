//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.register(UINib(nibName: "WelcomeCell", bundle: nil), forCellReuseIdentifier: "WelcomeCell")
        table.refreshControl = refreshControl
        
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
        
    }()
    

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])

        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "icoSearch"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .pumpkin
        
        let addButton = UIButton(type: .custom)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "icoNew"), for: .normal)

        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0)
        ])
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0, weight: .bold)]
        tableView.refreshControl = refreshControl
        viewModel.viewWasLoaded()
        
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    @objc func refreshControlPulled(){
        viewModel.viewWasLoaded()
        
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeCell", for: indexPath) as? WelcomeCell {
                let cellViewModel = viewModel.viewModel(at: indexPath) as? WelcomeCellViewModel
                cell.viewModel = cellViewModel
                return cell
                }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel{
                cell.viewModel = cellViewModel
                return cell
            }
        }

        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 151
        } else {
            return 96
        }
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func userImageFetched() {
        tableView.reloadData()
    }
    
    func topicsFetched() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}

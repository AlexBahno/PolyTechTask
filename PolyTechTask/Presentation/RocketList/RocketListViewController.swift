//
//  ViewController.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 09.04.2024.
//

import UIKit
import Combine
import SnapKit

class RocketListViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel = RocketListViewModel()
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RocketTableCell.self, forCellReuseIdentifier: RocketTableCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchRockets()

        title = "Rocket List"
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupBinding()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupActivityIndicator()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        viewModel.$rockets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
}

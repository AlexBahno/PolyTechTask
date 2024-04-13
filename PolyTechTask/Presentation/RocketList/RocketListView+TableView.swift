//
//  RocketListView+TableView.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 10.04.2024.
//

import UIKit

extension RocketListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RocketTableCell.identifier, for: indexPath)
                as? RocketTableCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: .init(rocket: viewModel.rockets[indexPath.row]))
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = RocketDetailsViewModel(rocket: viewModel.rockets[indexPath.row])
        let vc = RocketDetailsViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

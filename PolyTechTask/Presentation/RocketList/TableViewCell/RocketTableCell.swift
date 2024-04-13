//
//  RocketTableCell.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 10.04.2024.
//

import UIKit
import SnapKit

class RocketTableCell: UITableViewCell {
    
    static let identifier = "RocketTableCell"
        
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let firstFlightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let successRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let massLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let flightSuccessStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rocketParametrsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupNameLabel()
        setupFlightSuccessStack()
        setupRocketParametrsStack()
    }
    
    private func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupFlightSuccessStack() {
        self.contentView.addSubview(flightSuccessStack)

        flightSuccessStack.addArrangedSubview(firstFlightLabel)
        flightSuccessStack.addArrangedSubview(successRateLabel)
        
        flightSuccessStack.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupRocketParametrsStack() {
        self.contentView.addSubview(rocketParametrsStack)
        
        rocketParametrsStack.addArrangedSubview(heightLabel)
        rocketParametrsStack.addArrangedSubview(diameterLabel)
        rocketParametrsStack.addArrangedSubview(massLabel)
        
        rocketParametrsStack.snp.makeConstraints { make in
            make.top.equalTo(flightSuccessStack.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    func setupCell(with viewModel: RocketCellViewModel) {
        nameLabel.text = viewModel.rocket.rocketName
        firstFlightLabel.text = "First flight:\n\(viewModel.rocket.firstFlight ?? "")"
        successRateLabel.text = "Success rate:\n\(viewModel.rocket.successRatePct ?? 0)%"
        heightLabel.text = "Height:\n\(viewModel.rocket.height?.meters ?? 0) meters"
        diameterLabel.text = "Diameter:\n\(viewModel.rocket.diameter?.meters ?? 0) meters"
        massLabel.text = "Mass:\n\(viewModel.rocket.mass?.kg ?? 0) kg"
    }
}

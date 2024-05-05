//
//  RocketDetailsView.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 10.04.2024.
//

import UIKit
import SnapKit

class RocketDetailsViewController: UIViewController {
    
    var viewModel: RocketDetailsViewModel
    
    init(viewModel: RocketDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var myView: RocketDetailsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = RocketDetailsView(viewModel: viewModel, navController: navigationController)
        viewModel.fetchLaunches()
        myView?.injectIn(view: self.view)
        title = viewModel.rocket.rocketName
    }
}

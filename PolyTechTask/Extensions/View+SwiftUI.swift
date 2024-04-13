//
//  View+SwiftUI.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 12.04.2024.
//

import SwiftUI
import SnapKit

extension View {
    
    func injectIn(controller vc: UIViewController) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        vc.view.addSubview(controller.view)
        
        controller.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func injectIn(view: UIView) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        view.addSubview(controller.view)
        
        controller.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

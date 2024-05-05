//
//  View+SwiftUI.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 12.04.2024.
//

import SwiftUI
import SnapKit

extension View {
    
    func injectIn(view: UIView) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        view.addSubview(controller.view)
        
        controller.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

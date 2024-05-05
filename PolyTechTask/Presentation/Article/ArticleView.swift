//
//  ArticleViewController.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 12.04.2024.
//
import WebKit
import SwiftUI
import UIKit
import SnapKit

class ArticleView: UIViewController {
    
    var viewModel: ArticleViewModel
    
    private let webView: WKWebView = {
        let pref = WKPreferences()
        
        let pagePrefs = WKWebpagePreferences()
        pagePrefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.preferences = pref
        config.defaultWebpagePreferences = pagePrefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Article"
        view.backgroundColor = .white
        configView()
    }
    
    private func configView() {
        guard let url = URL(string: viewModel.url) else { return }
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ArticleView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard result != nil, error == nil else {
                print("Failed to get html")
                return
            }
        }
    }
}

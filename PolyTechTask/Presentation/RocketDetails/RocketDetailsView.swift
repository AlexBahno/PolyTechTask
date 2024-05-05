//
//  RocketDetailsView.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 12.04.2024.
//

import SwiftUI
import UIKit
import Alamofire
import AlamofireImage

struct RocketDetailsView: View {
    
    @ObservedObject var viewModel: RocketDetailsViewModel
    var navController: UINavigationController?
    
    var body: some View {
        NavigationView {
            if !viewModel.isNoLaunches {
                contentView
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("There is no launches with this rocket")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24))
                        .padding(.horizontal, 8)
                    Spacer()
                }
            }
        }
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.launches) { launch in
                LaunchCellView(launch: launch, navController: navController)
            }
            .listStyle(.plain)
        }
    }
}

struct LaunchCellView: View {
    
    let launch: Launch
    var navController: UINavigationController?
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            missionName
            if let details = launch.details {
                description(details: details)
            }
            dateAndSuccessStack
            articleLink
                .onTapGesture {
                    let vm = ArticleViewModel(url: launch.links?.articleLink ?? launch.links?.wikipedia ?? "")
                    navController?.pushViewController(ArticleView(viewModel: vm), animated: true)
                }
            imageView
        }
        .onAppear {
            self.imageLoader.loadImage(with: launch.links?.missionPatchSmall ?? "")
        }
    }
    
    private var missionName: some View {
        Text(launch.missionName ?? "")
            .font(.system(size: 24, weight: .medium))
            .lineLimit(0)
            .padding(.top, 5)
            .foregroundStyle(.black)
    }
    
    private func description(details: String) -> some View {
        Text(details)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 18, weight: .light))
            .padding(.top, 5)
            .foregroundStyle(.black)
    }
    
    private var dateAndSuccessStack: some View {
        HStack(alignment: .center) {
            Text("Launch date:\n\(convertDate())")
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(.black)
            Spacer()
            Text("Launch:\n\(launch.launchSuccess ?? false ? "Successful" : "Failed")")
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.top, 5)
    }
    
    private var articleLink: some View {
        Text("Link to the article: \(launch.links?.articleLink ?? launch.links?.wikipedia ?? "")")
            .font(.system(size: 18))
            .foregroundStyle(.black)
            .padding(.top, 5)
    }
    
    private var imageView: some View {
        HStack {
            Spacer()
            VStack {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(height: 130)
            .padding(.top, 5)
            .padding(.bottom, 5)
            Spacer()
        }
    }
    
    private func convertDate() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFullDate
        let date = dateFormatter.date(from: launch.launchDate ?? "")?.formatted(date: .abbreviated, time: .omitted)
        guard let date = date else {
            return "Invalid date"
        }
        return date
    }
}

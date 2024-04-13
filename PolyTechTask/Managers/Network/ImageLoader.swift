//
//  ImageLoader.swift
//  PolyTechTask
//
//  Created by Alexandr Bahno on 12.04.2024.
//

import UIKit
import Combine
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)

class ImageLoader: ObservableObject {

    @Published private(set) var image: UIImage?
    @Published var isLoading = false
    private var cancellableSet: Set<AnyCancellable> = []

    func loadImage(with url: String) {
        guard let image = imageCache.image(withIdentifier: url) else {
            AF.request(url)
                .validate()
                .responseImage { [weak self] response in
                    if response.value != nil {
                        let image = UIImage(data: response.data!)!
                        self?.image = image
                        imageCache.add(image, withIdentifier: url)
                    }
                }
            return
        }
        self.image = image
    }
}

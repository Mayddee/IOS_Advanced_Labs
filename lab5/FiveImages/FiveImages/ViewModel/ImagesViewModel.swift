import Foundation
import SwiftUI

final class ImagesViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading: Bool = false

    func getImages() {
        guard !isLoading else { return } // Prevent multiple fetches at the same time
        isLoading = true
        var tempImages: [ImageModel] = []
        let group = DispatchGroup()

        // Generate random image URLs each time
        let urlStrings: [String] = (0...4).map { _ in
            "https://picsum.photos/\(Int.random(in: 100...1000))/300"
        }

        for url in urlStrings {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                self.downloadImage(urlString: url) { model in
                    if let model = model {
                        DispatchQueue.main.async {
                            tempImages.append(model)
                        }
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.images.append(contentsOf: tempImages) // Add the new images to the existing ones
            self.isLoading = false
        }
    }

    private func downloadImage(urlString: String, completion: @escaping (ImageModel?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            if let safeData = data, let uiImage = UIImage(data: safeData) {
                let randomHeight = CGFloat(Int.random(in: 150...300)) // Randomize height for variation
                let imageModel = ImageModel(image: Image(uiImage: uiImage), height: randomHeight)
                completion(imageModel)
            } else {
                print("Failed to create image")
                completion(nil)
            }
        }.resume()
    }
}


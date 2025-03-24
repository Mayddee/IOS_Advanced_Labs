import SwiftUI
import UIKit

final class HeroRouter {
    var rootViewController: UINavigationController?

    func showDetails(for id: Int) {
        let detailVC = makeDetailViewController(id: id)
        rootViewController?.pushViewController(detailVC, animated: true)
    }

    private func makeDetailViewController(id: Int) -> UIViewController {
        let service = HeroServiceImpl()
        let viewModel = HeroDetailsViewModel(service: service, heroId: id)
        let detailView = HeroDetailsView(viewModel: viewModel)

        return UIHostingController(rootView: detailView)
    }
}

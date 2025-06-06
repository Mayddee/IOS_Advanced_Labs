import SwiftUI

final class HeroListViewModel: ObservableObject {
    @Published private(set) var heroes: [HeroListModel] = []
    @Published var isLoading: Bool = false // Добавляем свойство isLoading

    private let service: HeroService
    private let router: HeroRouter

    init(service: HeroService, router: HeroRouter) {
        self.service = service
        self.router = router
    }

    func fetchHeroes() async {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            let heroesResponse = try await service.fetchHeroes()

            await MainActor.run {
                heroes = heroesResponse.map {
                    HeroListModel(
                        id: $0.id,
                        title: $0.name,
                        description: $0.appearance.race ?? "No Race",
                        heroImage: $0.heroImageUrl
                    )
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
            }
            print("Error: \(error.localizedDescription)")
        }
    }

    func routeToDetail(by id: Int) {
        router.showDetails(for: id)
    }
}

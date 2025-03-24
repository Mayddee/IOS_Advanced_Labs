import SwiftUI

import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel: HeroListViewModel
    @State private var searchText: String = ""

    var filteredHeroes: [HeroListModel] {
        if searchText.isEmpty {
            return viewModel.heroes
        } else {
            return viewModel.heroes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.pink, .blue.opacity(0.7)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Superheroes")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    searchBar()

                    Divider().background(Color.white.opacity(0.7))

                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        listOfHeroes()
                    }

                    Spacer()
                }
                .padding()
            }
            .task {
                await viewModel.fetchHeroes()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Hero List & Cards
extension HeroListView {
    @ViewBuilder
    private func listOfHeroes() -> some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(filteredHeroes) { model in
                    heroCard(model: model)
                        .padding(.horizontal, 16)
                        .transition(.slide)
                }
            }
            .padding(.top, 10)
        }
    }

    @ViewBuilder
    private func heroCard(model: HeroListModel) -> some View {
        HStack {
            AsyncImage(url: model.heroImage) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                default:
                    Color.gray
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)

                Text(model.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
        .onTapGesture {
            viewModel.routeToDetail(by: model.id)
        }
    }

    // MARK: - Search Bar
    @ViewBuilder
    private func searchBar() -> some View {
        HStack {
            TextField("Search heroes...", text: $searchText)
                .padding(8)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.horizontal)

            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.trailing)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

import SwiftUI

class FavouriteViewModel: ObservableObject {
    @AppStorage("favoriteMovies") private var favouritesData: Data = Data()
    @Published var favourites: [MovieData] = []

    init() {
        loadFavorites()
    }

    func addToFavorites(_ movie: MovieData) {
        if !favourites.contains(where: { $0.movieID == movie.movieID }) {
            favourites.append(movie)
            saveFavorites()
        }
    }

    func removeFromFavorites(_ movie: MovieData) {
        favourites.removeAll { $0.movieID == movie.movieID }
        saveFavorites()
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favourites) {
            favouritesData = encoded
        }
    }

    private func loadFavorites() {
        if let decoded = try? JSONDecoder().decode([MovieData].self, from: favouritesData) {
            favourites = decoded
        }
    }
}

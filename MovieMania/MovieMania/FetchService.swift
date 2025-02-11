import Foundation

@MainActor
class FetchService: ObservableObject {
    @Published var searchResults:[Movie.MovieData] = []
    @Published var popularMovies: [Movie.MovieData] = []
    @Published var topRatedMovies: [Movie.MovieData] = []
    @Published var upcomingMovies: [Movie.MovieData] = []
    
    let baseURL = "https://api.themoviedb.org/3/movie"
    let apiKey = "c3957c0341f6ceb7b221d37abf80c151"

    func fetchMovies(category: String) async {
        guard let url = URL(string: "\(baseURL)/\(category)?api_key=\(apiKey)&language=en-US&page=1") else {
            print("Invalid URL for \(category)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(Movie.self, from: data)
            
            switch category {
                case "popular":
                    popularMovies = response.results
                case "top_rated":
                    topRatedMovies = response.results
                case "upcoming":
                    upcomingMovies = response.results
                default:
                    break
            }
        } catch {
            print("Failed to fetch \(category): \(error.localizedDescription)")
        }
    }
    
 func searchMovies(query: String) async {
            guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery)&language=en-US&page=1") else {
                print("Invalid search URL")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(Movie.self, from: data)
                searchResults = response.results
            } catch {
                print("Search failed: \(error.localizedDescription)")
            }
        }
    
    }
    
   


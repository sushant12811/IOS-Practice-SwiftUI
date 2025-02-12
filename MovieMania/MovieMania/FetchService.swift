import Foundation

@MainActor
class FetchService: ObservableObject {
    @Published var searchResults:[Movie.MovieData] = []
    @Published var popularMovies: [Movie.MovieData] = []
    @Published var topRatedMovies: [Movie.MovieData] = []
    @Published var upcomingMovies: [Movie.MovieData] = []

    
    let baseURL = "https://api.themoviedb.org/3/movie"
    let apiKey = "c3957c0341f6ceb7b221d37abf80c151"
    
    //MARK: Category of movie fetching
    func fetchMovies(category: String, page:Int = 1) async {
        guard let url = URL(string: "\(baseURL)/\(category)?api_key=\(apiKey)&language=en-US&\(page)") else {
            print("Invalid URL for \(category)")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            print("Raw JSON Response: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedResponse = try decoder.decode(Movie.self, from: data)
            
            switch category {
            case "popular":
                popularMovies = decodedResponse.results
            case "top_rated":
                topRatedMovies = decodedResponse.results
            case "upcoming":
                upcomingMovies = decodedResponse.results
            default:
                break
            }
        } catch {
            print("Failed to fetch \(category): \(error.localizedDescription)")
        }
    }
    
    
    //MARK: Search Query Fetching Service
    func searchMovies(query: String) async {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery)") else {
            print("Invalid search URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            print("Raw JSON Response: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedResponse = try decoder.decode(Movie.self, from: data)
            await MainActor.run {
                self.searchResults = decodedResponse.results
            }
        } catch {
            print("Decoding error: \(error.localizedDescription)")
        }
        
    }
    
}


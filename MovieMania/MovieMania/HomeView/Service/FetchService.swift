import Foundation

@MainActor
class FetchService: ObservableObject {
    @Published var searchResults: [Movie.MovieData] = []
    @Published var popularMovies: [Movie.MovieData] = []
    @Published var topRatedMovies: [Movie.MovieData] = []
    @Published var upcomingMovies: [Movie.MovieData] = []
    @Published var movieCast: [Cast.CastData] = []
    @Published var video: [Video.VideoData] = []

    
    let baseURL = "https://api.themoviedb.org/3/movie"
    let apiKey = "c3957c0341f6ceb7b221d37abf80c151"
    
    // MARK: Category of movie fetching
    func fetchMovies(category: String, page: Int = 1) async {
        guard let url = URL(string: "\(baseURL)/\(category)?api_key=\(apiKey)&language=en-US&page=\(page)") else {
            print("Invalid URL for \(category)")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedResponse = try decoder.decode(Movie.self, from: data)
            
            await MainActor.run {
                switch category {
                case "popular":
                    self.popularMovies.append(contentsOf: decodedResponse.results)
                case "top_rated":
                    self.topRatedMovies.append(contentsOf: decodedResponse.results)
                case "upcoming":
                    self.upcomingMovies.append(contentsOf: decodedResponse.results)
                default:
                    break
                }
            }
        } catch {
            print("Failed to fetch \(category): \(error.localizedDescription)")
        }
    }
    
    // MARK: Search Query Fetching Service
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
    
    //MARK: Fetching Cast Service
    
    func fetchedMovieDetailsTopic(of movieId: Int, for movieTopic: String) async {
        guard let url = URL(string: "\(baseURL)/\(movieId)/\(movieTopic)?api_key=\(apiKey)") else {
            print("Invalid URL for the \(movieTopic)")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
           
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let jsonString = String(data: data, encoding: .utf8)
                    print("Raw API Response for \(movieTopic): \(jsonString ?? "No data")")

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            await MainActor.run {
                do {
                    switch movieTopic {
                    case "credits":
                        let decodedResponse = try decoder.decode(Cast.self, from: data)
                        self.movieCast.append(contentsOf: decodedResponse.cast)
                        
                    case "videos":
                        let decodedResponse = try decoder.decode(Video.self, from: data)
                        self.video.append(contentsOf: decodedResponse.results)
                        
                    default:
                        print("Unknown movie topic: \(movieTopic)")
                    }
                } catch {
                    print("Failed to decode \(movieTopic): \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to fetch \(movieTopic): \(error.localizedDescription)")
        }
    }

}

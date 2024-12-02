//
//  apiService.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//

import Foundation


class ApiService {
    
    private let baseUrl: String = "https://api.themoviedb.org/3"
    private let jwt: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjc0MDYxYmY4MzlmYjZhODlmMjUxZDBkMTI2OTczMCIsIm5iZiI6MTcxNDI3NzkxNi4yNjU5OTk4LCJzdWIiOiI2NjJkY2UxYzUxMWQwOTAxMjFjNTFkMGEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.pv_9ASjP2beka5NtLWh7WRzArpmVAHpC-YagTDcyfu4"
  


    private func createRequest(endpoint: String, method: String = "GET", queryParameters: [String: String]? = nil) -> URLRequest? {
        var urlComponents = URLComponents(string: "\(baseUrl)/\(endpoint)")
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents?.url else {
            print("Invalid URL for endpoint: \(endpoint)")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    
    private func performRequest<T: Decodable>(
        request: URLRequest,
        decodingType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let error = NSError(
                    domain: "ApiService",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(httpResponse.statusCode)"]
                )
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(
                    domain: "ApiService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "No data received"]
                )
                completion(.failure(error))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(decodingType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


    func searchMovies(
            query: String,
            includeAdult: Bool = false,
            language: String = "en-US",
            page: Int = 1,
            completion: @escaping (Result<[Movie], Error>) -> Void) {
                
        let endpoint = "search/movie"
        let queryParameters: [String: String] = [
            "query": query,
            "include_adult": "\(includeAdult)",
            "language": language,
            "page": "\(page)"
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }

        performRequest(request: request, decodingType: MovieResponse.self) { result in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    
    func getMoviesNowPlaying(
            language: String = "en-US",
            page: Int = 1,
            completion: @escaping (Result<[Movie], Error>) -> Void) {
                
        let endpoint = "movie/now_playing"
        let queryParameters: [String: String] = [
            "language": language,
            "page": "\(page)"
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }

        performRequest(request: request, decodingType: MovieResponse.self) { result in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    
    func getMoviesPopular(
            language: String = "en-US",
            page: Int = 2,
            completion: @escaping (Result<[Movie], Error>) -> Void) {
                
        let endpoint = "movie/popular"
        let queryParameters: [String: String] = [
            "language": language,
            "page": "\(page)"
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }

        performRequest(request: request, decodingType: MovieResponse.self) { result in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getMoviesTopRated(
            language: String = "en-US",
            page: Int = 1,
            completion: @escaping (Result<[Movie], Error>) -> Void) {
                
        let endpoint = "movie/top_rated"
        let queryParameters: [String: String] = [
            "language": language,
            "page": "\(page)"
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }

        performRequest(request: request, decodingType: MovieResponse.self) { result in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getMoviesUpcoming(
            language: String = "en-US",
            page: Int = 1,
            completion: @escaping (Result<[Movie], Error>) -> Void) {
                
        let endpoint = "movie/upcoming"
        let queryParameters: [String: String] = [
            "language": language,
            "page": "\(page)"
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }

        performRequest(request: request, decodingType: MovieResponse.self) { result in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    func getGenres(language: String = "es",completion: @escaping (Result<[Genre], Error>) -> Void) {
        let endpoint = "genre/movie/list"
        let queryParameters: [String: String] = [
            "language": language,
        ]

        guard let request = createRequest(endpoint: endpoint, queryParameters: queryParameters) else {
            completion(.failure(NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])))
            return
        }
        
        performRequest(request: request, decodingType: GenresResponse.self) { result in
            switch result {
            case .success(let genresResponse):
                completion(.success(genresResponse.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        


    }
    
}

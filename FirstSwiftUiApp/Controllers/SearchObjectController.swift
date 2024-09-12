//
//  SearchObjectController.swift
//  FirstSwiftUiApp
//
//  Created by Om Parihar on 12/09/24.
//

import Foundation
import SwiftUI

class SearchObjectController: ObservableObject {
    static let shared = SearchObjectController()
    private init() {}
    
    var token = "uBTJCwXtZnWD4I4IQ8t-90s47Ibfu2mpyGmdxCMzJ-k"
    @Published var results = [UnsplashImage]()
    @Published var searchText: String = "" {
        didSet {
            search()
        }
    }
    
    func search() {
        guard !searchText.isEmpty, let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&client_id=\(token)") else {
            print("Invalid search query or URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = decodedResponse.results
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}



import Foundation

// Response structure from Unsplash API
struct UnsplashResponse: Codable {
    let results: [UnsplashImage]
}

// Data model for an image
struct UnsplashImage: Codable, Identifiable {
    let id: String
    let urls: [String: String]
    let description: String?
}

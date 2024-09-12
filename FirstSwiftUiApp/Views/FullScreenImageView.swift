//
//  FullScreenImageView.swift
//  FirstSwiftUiApp
//
//  Created by Om Parihar on 12/09/24.
//

import SwiftUI

struct FullScreenImageView: View {
    let image: UnsplashImage
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.urls["full"] ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Text(image.description ?? "No Description")
                .padding()
            Button(action: {
                shareImage(url: URL(string: image.urls["full"] ?? "")!)
            }) {
                Text("Share")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    private func shareImage(url: URL) {
        print("Sharing URL: \(url)")
        guard UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL")
            return
        }
        
        // Share the image URL
        let activityItems: [Any] = [url]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityController, animated: true)
        }
    }
}



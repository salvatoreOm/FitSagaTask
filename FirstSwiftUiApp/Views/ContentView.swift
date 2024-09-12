//
//  ContentView.swift
//  FirstSwiftUiApp
//
//  Created by Om Parihar on 11/09/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var searchObjectController = SearchObjectController.shared
    @State private var selectedImage: UnsplashImage?
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $searchText, onCommit: {
                    searchObjectController.searchText = searchText
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

                List(searchObjectController.results) { result in
                    Button(action: {
                        selectedImage = result
                    }) {
                        HStack {
                            AsyncImage(url: URL(string: result.urls["regular"] ?? "")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(result.description ?? "No Description")
                                .lineLimit(1)
                        }
                    }
                }
                .sheet(item: $selectedImage) { image in
                    FullScreenImageView(image: image)
                }
            }
            .navigationTitle("Unsplash Images")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





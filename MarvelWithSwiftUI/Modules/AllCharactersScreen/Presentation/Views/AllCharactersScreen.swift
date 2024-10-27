//
//  AllCharactersScreen.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 23/10/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct AllCharactersScreen: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: AllCharactersViewModel
    
    init(viewModel: AllCharactersViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            CharacterItemView(image: character.thumbnail, title: character.title)
                        }
                    }
                }
            }.onAppear() {
                viewModel.fetchCharacters()
            }.alert(isPresented: .constant((viewModel.error) != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "Unknown Error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("marvel-icon")
                        .resizable()
                        .frame(width: 90, height: 40)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    let repository = AllCharactersRepository()
    let useCase = AllCharactersUsecases(repository: repository)
    let viewModel = AllCharactersViewModel(allCharactersUseCase: useCase)
    //    AllCharactersScreen(viewModel: viewModel)
    CharacterItemView(image: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", title: "hi from iOS")
}

struct CharacterItemView: View {
    @State var image: String
    @State var title: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .lineLimit(1)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                    .background(Color.white)
            }
            .padding(20)
            .padding(.horizontal, 20)
        }
    }
}

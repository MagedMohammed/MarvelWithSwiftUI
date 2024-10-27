//
//  ContentView.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 23/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let repository = AllCharactersRepository()
        let useCase = AllCharactersUsecases(repository: repository)
        let viewModel = AllCharactersViewModel(allCharactersUseCase: useCase)
        AllCharactersScreen(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}


//
//  MarvelWithSwiftUIApp.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 23/10/2024.
//

import SwiftUI

@main
struct MarvelWithSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = AllCharactersRepository()
            let useCase = AllCharactersUsecases(repository: repository)
            let viewModel = AllCharactersViewModel(allCharactersUseCase: useCase)
            AllCharactersScreen(viewModel: viewModel)
        }
    }
}

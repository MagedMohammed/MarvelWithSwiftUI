//
//  AllCharactersViewModel.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 27/10/2024.
//

import Combine
import SwiftUI

protocol AllCharactersViewModelProtocol {
    var characters: [Character] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    
    func fetchCharacters()
}

class AllCharactersViewModel: AllCharactersViewModelProtocol, ObservableObject {
    
    //  MARK: - Properties
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var error: (any Error)? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let allCharactersUseCase: AllCharactersUsecasesProtocol
    
    //  MARK: - Initializers
    init(allCharactersUseCase: AllCharactersUsecasesProtocol) {
        self.allCharactersUseCase = allCharactersUseCase
    }
    
    //  MARK: - Methods
    func fetchCharacters() {
        self.isLoading = true
        self.allCharactersUseCase.fetchAllCharacters().receive(on: DispatchQueue.main).sink {[weak self] completion in
            guard let self else { return }
            self.isLoading = false
            switch completion {
            case .failure(let error):
                self.error = error
            case .finished:
                break
            }
        } receiveValue: {[weak self] characters in
            guard let self else { return }
            self.isLoading = false
            self.characters = characters
        }
        .store(in: &cancellables)
    }
}

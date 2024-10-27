//
//  AllCharactersUsecases.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 27/10/2024.
//
import Combine


protocol AllCharactersUsecasesProtocol {
    func fetchAllCharacters() -> AnyPublisher<[Character], Error>
}

class AllCharactersUsecases: AllCharactersUsecasesProtocol {
    private let allCharactersRepository: AllCharactersRepositoryProtocol
    
    init(repository: AllCharactersRepositoryProtocol) {
        self.allCharactersRepository = repository
    }
    
    func fetchAllCharacters() -> AnyPublisher<[Character], Error> {
        return allCharactersRepository.fetchAllCharacters()
    }
}

//
//  AllCharactersRepository.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 27/10/2024.
//

import Foundation
import Combine

protocol AllCharactersRepositoryProtocol {
    func fetchAllCharacters() -> AnyPublisher<[Character], Error>
}

class AllCharactersRepository: AllCharactersRepositoryProtocol {
    private let api: APIClientProtocol
    private var cancellables = Set<AnyCancellable>()
    let subject = PassthroughSubject<[Character], Error>()
    
    init() {
        self.api = APIClient()
    }
    
    func fetchAllCharacters() -> AnyPublisher<[Character], Error> {
        
        api.fetchData(requestConvertible: MarvelRouter.ListOfCharacters(1))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.subject.send(completion: .failure(error)) // Send the error to the subject
                }
            }, receiveValue: { (charactersFullModel: CharactersFullModel) in
                if let characterData = charactersFullModel.data?.results {
                    let characters = characterData.map { Character(data: $0) }
                    self.subject.send(characters) // Send the processed characters array to subscribers
                }
            })
            .store(in: &cancellables)
        
        // Convert `subject` to `AnyPublisher` and return
        return subject.eraseToAnyPublisher()
    }
    
}

//
//  CharacterModel.swift
//  MarvelWithSwiftUI
//
//  Created by Maged on 27/10/2024.
//

class Character: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var thumbnail: String
    
    init(data: CharacterModel) {
        id = data.id ?? Int()
        title = data.name ?? ""
        description = data.description ?? ""
        thumbnail = ((data.thumbnail?.path ?? "") + "." + (data.thumbnail?.thumbnailExtension ?? ""))
    }
}

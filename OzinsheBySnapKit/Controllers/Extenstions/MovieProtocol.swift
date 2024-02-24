//
//  MovieProtocol.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 20.02.2024.
//

protocol MovieProtocol {
    func movieDidSelect(movie: Movie)
    func genreDidSelect(genreId: Int, genreName: String)
    func ageCategoryDidSelect(categoryAgeId: Int)
}

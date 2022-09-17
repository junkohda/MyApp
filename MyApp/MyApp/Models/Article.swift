//
//  Article.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/17.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable{
    let title: String
    let description: String?
}


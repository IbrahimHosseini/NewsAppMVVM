//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Ibrahim on 9/11/22.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String?
}

struct ArticleResponse: Decodable {
    let articles: [Article]
}

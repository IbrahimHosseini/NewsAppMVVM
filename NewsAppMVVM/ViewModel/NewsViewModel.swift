//
//  NewsViewModel.swift
//  NewsAppMVVM
//
//  Created by Ibrahim on 9/11/22.
//

import Foundation
import RxCocoa
import RxSwift


struct ArticleListViewmodel {
    let articleVM: [ArticleViewModel]
}

extension ArticleListViewmodel {
    init(articles: [Article]) {
        self.articleVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewmodel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        self.articleVM[index]
    }
}

struct ArticleViewModel {
    
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}

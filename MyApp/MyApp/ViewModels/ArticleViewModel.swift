//
//  ArticleViewModel.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/17.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]){
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func articleAt(_ index:Int)->ArticleViewModel {
        return self.articlesVM[index]
    }
}


struct ArticleViewModel {
    let article: Article

    init(_ article:Article) {
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
    
    var urlToImage: Observable<String> {
        return Observable<String>.just(article.urlToImage ?? "")
    }
}

struct ArticleImageListViewModel {
    let articleImagesVM: [ArticleImageViewModel]
}

extension ArticleImageListViewModel {
    init(_ articleImages: [ArticleImage]){
        self.articleImagesVM = articleImages.compactMap(ArticleImageViewModel.init)
    }
}

extension ArticleImageListViewModel {
    func articleImageAt(_ index:Int)->ArticleImageViewModel {
        return self.articleImagesVM[index]
    }
}


struct ArticleImageViewModel {
    let articleImage: ArticleImage

    init(_ articleImage:ArticleImage) {
        self.articleImage = articleImage
    }
}

extension ArticleImageViewModel {
    var image: Observable<Data> {
        return Observable<Data>.just(articleImage.image!)
    }
}

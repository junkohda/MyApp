//
//  NewsTableViewController.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/17.
//

import Foundation
import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    private var articleImageListVM: ArticleImageListViewModel!
    
    @IBAction func refleshButtonPressed() {
        self.populateNews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    private func populateNews() {
        let resource = Resource<ArticleResponse>(url: URL(string: ConstStruct.newsURL)!)
    
        URLRequest.load(resource: resource)
            .subscribe(onNext:{ articleResponse in
                
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    
    }
    
    private func getImage(_ url:Observable<String>) {
        let resource = Resource<ArticleImageResponse>(url: URL(string: url)!)
    
        URLRequest.load(resource: resource)
            .subscribe(onNext:{ articleImageResponse in
                
                let articleImages = articleImageResponse.articleImages
                self.articleImageListVM = ArticleImageListViewModel(articleImages)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell" ,for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell is not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.getImage(articleVM.urlToImage)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        let articleVM = self.articleListVM.articleAt(indexPath.row)
    }
}

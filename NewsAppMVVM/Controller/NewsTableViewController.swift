//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Ibrahim on 9/11/22.
//

import UIKit
import RxCocoa
import RxSwift

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    private var articleListVM: ArticleListViewmodel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        popularNews()
    }
    
    
    private func popularNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=4292670cd6c2445bb6dc0a5bc12e5d38")!
        let resource = Resource<ArticleResponse>(url: url)
        
        URLRequest.load(response: resource)
            .subscribe(onNext: { response in
                
                let response = response.articles
                self.articleListVM = ArticleListViewmodel(articles: response)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM == nil ? 0 : articleListVM.articleVM.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArticelTableViewCell else { fatalError("Not found") }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLable.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLable.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
}

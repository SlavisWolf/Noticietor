//
//
//
//
// 
//

import UIKit

class HomeController: BaseController, TopSearchBarInterface, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var topBar: TopSearchBar!
    @IBOutlet weak var labelNoNews: UILabel!
    @IBOutlet weak var tableArticles: UITableView!
    
    var articles = [Article]()
    let cellID = "article_cell_ID"
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.config(text: "news".localized(), delegate: self)
        
        labelNoNews.text = "no_news".localized()
        labelNoNews.textColor = Colors.color3
        labelNoNews.font = Fonts.regular(15)
        
        tableArticles.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableArticles.separatorStyle = .none
        tableArticles.delegate = self
        tableArticles.dataSource = self
        loadArticles()
    }
    
    private func loadArticles(_ search: String? = nil) {
        
        ArticleRequest().getArticles(search ?? "Actualidad").subscribe(onSuccess: { articles in
            self.articles = articles
            if articles.isEmpty {
                self.labelNoNews.isHidden = false
                self.tableArticles.isHidden = true
            }
            else {
                self.labelNoNews.isHidden = true
                self.tableArticles.isHidden = false
            }
            
            self.tableArticles.reloadData()
        }).disposed(by: disposeBag)
    }

    //MARK: Top bar interface
    func fieldReturn(_ text: String?) {
        loadArticles(text)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ArticleCell else {
            return ArticleCell()
        }
        cell.config(articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ArticleController.create()
        controller.article = articles[indexPath.row]
        pushController(controller)
    }
}

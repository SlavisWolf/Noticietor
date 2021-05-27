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
    let defaultSearch = "Actualidad"
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
        tableArticles.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        loadArticles()
    }
    //MARK: Private
    private func loadArticles(_ search: String? = nil) {
        //Antes limpiamos los espacios en blanco laterales y si el texto es nulo o esta vacio asignamos el string po defecto
        let trimmingText = search?.trimmingCharacters(in: .whitespacesAndNewlines) ?? defaultSearch
        let finalSearch = trimmingText.isEmpty ? defaultSearch : trimmingText
        ArticleInteractor.searchArticles(finalSearch).subscribe(onSuccess: { articles in
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

    private func articleClicked(_ article: Article) {
        let controller = ArticleController.create()
        controller.article = article
        pushController(controller)
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
        let article = articles[indexPath.row]
        cell.config(article, onClick: {self.articleClicked(article)})
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

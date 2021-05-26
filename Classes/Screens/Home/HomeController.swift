//
//
//
//
// 
//

import UIKit

class HomeController: BaseController {

    //MARK: Outlets
    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var labelNoNews: UILabel!

    
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.config(text: "news".localized(), delegate: self, typeRight: .more, typeRight2: .refresh)
        
        labelNoNews.text = "no_news".localized()
        labelNoNews.textColor = Colors.color3
        labelNoNews.font = Fonts.regular(15)
        
        ArticleRequest().getArticles("Actualidad").subscribe(onSuccess: { articles in
            
        }).disposed(by: disposeBag)
    }
    

    //MARK: Top bar interface
    override func rightClicked(_ sender: UIButton) {
        
    }
    
    override func right2Clicked(_ sender: UIButton) {
        
    }
}

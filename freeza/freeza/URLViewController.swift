import Foundation
import UIKit

class URLViewController: UIViewController {
    
    var url: URL?
    
    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!

    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()

        if let url = url {
        
            self.webView.loadRequest(URLRequest(url: url))
        }
    }
    @objc func toggleFavorite(){
         
    }
}

extension URLViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        self.activityIndicatorView.stopAnimating()
        let barButton = UIBarButtonItem(image: UIImage(named: "heart.png"), style: .done, target: self, action: #selector(toggleFavorite))
        self.navigationItem.rightBarButtonItem = barButton
    }
}

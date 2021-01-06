import Foundation
import UIKit

class URLViewController: UIViewController {
    
    var entryViewModel: EntryViewModel?
    var isFavorite: Bool = false
    
    @IBOutlet private weak var webView: UIWebView!

    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        self.isFavorite = entryViewModel?.isFavorite ?? false
        
        if let url = entryViewModel?.url {
        
            self.webView.loadRequest(URLRequest(url: url))
        }
    }
    @objc func toggleFavorite(_ sender: AnyObject) {
        func updateDestination(){
            if let nav = self.tabBarController?.viewControllers![0] as? UINavigationController {
                if let destinationViewController = nav.viewControllers[0] as? TopEntriesViewController {
                    destinationViewController.shouldUpdate = true
                }
            }
        }
        if isFavorite {
            entryViewModel?.deleteEntryToDB(){
            }
        } else {
            entryViewModel?.saveEntryToDB()
        }
        isFavorite = !isFavorite
        updateDestination()
        self.navigationItem.rightBarButtonItem = toggleBarButton()
    }
    func toggleBarButton() -> UIBarButtonItem {
        var image = UIImage(named: "heart.png")
        if isFavorite {
            image = UIImage(named: "heart-full.png")
        }
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavorite))
    }
}

extension URLViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        self.activityIndicatorView.stopAnimating()
        self.navigationItem.rightBarButtonItem = toggleBarButton()
    }
}


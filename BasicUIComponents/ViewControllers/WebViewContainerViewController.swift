//
//  WebViewContainerViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 18.09.2021.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    private var activityIndicatorView: UIActivityIndicatorView!
    
    var urlString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad() // html content gosterelim font ve font buyuklugunu css ile degistirelim
        
        activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .red
        activityIndicatorView.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: TimeInterval(8))
        
        webView.allowsBackForwardNavigationGestures = true
        webView.load(urlRequest)
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.isLoading),
                            options: .new,
                            context: nil)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webView.isLoading {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
            
            activityIndicatorView.isHidden = !webView.isLoading
        }
    }
    @IBAction func toolBarItems(_ sender: UIBarButtonItem) {
        //Webview bir gerideki sayfaya gönderir.
        if sender.tag == 1 {
            if webView.canGoBack {
                webView.goBack()
            }
        //Webview bir sonraki sayfaya gönderir.
        }else if sender.tag == 2 {
            if webView.canGoForward {
                webView.goForward()
            }
        //Webview safaride açar.
        }else if sender.tag == 3 {
            UIApplication.shared.openURL(self.webView.url!)
        //Webview sayfasını yeniler.
        }else {
            webView.reload()
        }
    }
}



extension WebViewContainerViewController: WKUIDelegate {
    
}

extension WebViewContainerViewController: WKNavigationDelegate {
    
}

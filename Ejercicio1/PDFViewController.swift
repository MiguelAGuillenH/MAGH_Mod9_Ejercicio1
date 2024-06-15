//
//  PDFViewController.swift
//  Ejercicio1
//
//  Created by DISMOV on 14/06/24.
//

import UIKit
import WebKit

class PDFViewController: UIViewController, WKNavigationDelegate {
    
    //Variables para UI
    var webView: WKWebView!
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(activityIndicatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = Bundle.main.url(forResource: "Concierto", withExtension: "pdf") {
            let request = URLRequest(url: url)
            webView.load(request)
            activityIndicatorView.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }

}

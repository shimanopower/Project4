//
//  ViewController.swift
//  Project4
//
//  Created by Tristan Jackson on 5/7/19.
//  Copyright © 2019 Tristan Jackson. All rights reserved.
//

import UIKit
import WebKit

// the ViewController class extends UIViewController, its parent class and it conforms to the WKNavigationDelegate protocol

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    
    // WKWebView is a Class/Object of WebKit
    
    // var webView: WKWebView!
    var progressView: UIProgressView!
    var urlString: String?
    var selectedPortfolio: String?
    
    // loadView() is an instance method of UIViewControler load and create a view and assign it to the view property
    
    override func loadView() {
        // create an instance of WKWebView class
        webView = WKWebView()
        // self is the current view controller
        webView.navigationDelegate = self
        // view is an instance property of UIViewController and it represents the root view for the view contller's view hierarchy ?
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationItem P of UIViewController is a navigation item used to represent the view controller in a parent's navigation bar
        
        // Here is the rightBarButtonItem is our Select Portfolio Button
        
        
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Portfolio", style: .plain, target: self, action: #selector(openWhatMyUserTapped))
        
        // Here we instantiate a progressView
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        // And here we instantiate a new our progressView as a UIBarButtonItem
        
        let progressButton = UIBarButtonItem(customView: progressView)
        // UIBarButtonItem is a class that is a specialized button for placement on a toolbar or a tab bar
        // flexibleSpace is an enum case
        
        // and here is our spacer
        
        let ourSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // and here is our refresh button
        
        let refeshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let forwardButton = UIBarButtonItem(title: "go forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        let backButton = UIBarButtonItem(title: "go back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        // toolbarItems is an instance proprty of UIViewController
        
        // and here we load up all our UIBarButtonItems into our toolbarItems array
        
        toolbarItems = [backButton, ourSpacer, progressButton, ourSpacer, refeshButton, ourSpacer, forwardButton]
        
        // navigationController? is an instance property inhereting from UINavigationControlelr
        // .isToolbarHidden bool, instance proprty of UINavigationController
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        // URL is a struct; a value set to a resource like a file or website; comes from the Foundation framework
        // ! force unwraps
        // let url = URL(string: "http://" + allowedWebsites["hero"]!)!
        // URLRequest is a struct independent of protodol or URL scheme. It encapsulates two basic data elements
        // .load is an instance method of WKWebView
        // webView.load(URLRequest(url: url))
        // .allowsBackForwardNavigationGesutres instance property of WKWebView / a bool allows backwards forward swiping between web pages
        
        if let urlString = selectedPortfolio {
            let url = URL(string: "http://" + urlString)!
            webView.load(URLRequest(url: url))
        }
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
        
        // Do any additional setup after loading the view.
        
    
    // @objc func openWhatMyUserTapped() {
        // UIAlertController, a class // object that is a part of an object group known collectively as windows and scenes, inherents from UIViewController, used to configure alerts and action sheets
       // let alertcontroller = UIAlertController(title: "open portfolio", message: nil, preferredStyle: .actionSheet)
        // UIAlertAction is an instance method of UIAlertController
        // note for later: take the title and replace it with bitch and then create a diction and use those titles as keys in the website with the values of the current titles (the websites)
       
        // for website in allowedWebsites {
          //  alertcontroller.addAction(UIAlertAction(title: website.key, style: .default, handler: openWebpage))
        //  }
        
        // alertcontroller.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        // .popoverPresentationController is an instance property of UIViewController
        //alertcontroller.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        // present an instance method of UIViewController that presents a view controller modally
       // present(alertcontroller, animated: true)
 //   }
    
   // func openWebpage(action: UIAlertAction) {
        // theURLOfTheWebsiteThatWeWantToOpen
    //    let url = URL(string: "https://" + allowedWebsites[action.title!]!)!
    //    webView.load(URLRequest(url: url))
   // }
    
    func denyAccessAlert(action: UIAlertAction! = nil) {
        let alertaction = UIAlertController(title: "DENIED", message: "That link leaves the hero/devil portfolio sites", preferredStyle: .alert)
        alertaction.addAction(UIAlertAction(title: "Alright", style: .default, handler: nil))
        present(alertaction, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // Here WKNavigationAction is supposed to controll the sites a WKWebView can vist but it doesn't for reasons unknown
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            // for website in allowedWebsites {
                // if host.contains(website.value) {
            if host.contains("audreysmonsters.com") || host.contains("shawndimpfl.com") {
                decisionHandler(.allow)
                return
            }
        }
        
        decisionHandler(.cancel)
        denyAccessAlert()
    }
}

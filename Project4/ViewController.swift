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

    // WKWebView is a Class/Object of WebKit
    
    var aViewOfAWebpage: WKWebView!
    
    // loadView() is an instance method of UIViewControler load and create a view and assign it to the view property
    
    override func loadView() {
        // create an instance of WKWebView class
        aViewOfAWebpage = WKWebView()
        // self is the current view controller
        aViewOfAWebpage.navigationDelegate = self
        // view is an instance property of UIViewController and it represents the root view for the view contller's view hierarchn ?
        view = aViewOfAWebpage
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openWhatMyUserTapped))
        // URL is a struct; a value set to a resource like a file or website; comes from the Foundation framework
        // ! force unwraps
        let urlOfMyPortfolioWebsite = URL(string: "https://www.audreysmonsters.com")!
        // URLRequest is a struct independent of protodol or URL scheme. It encapsulates two basic data elements
        // .load is an instance method of WKWebView
        aViewOfAWebpage.load(URLRequest(url: urlOfMyPortfolioWebsite))
        // .allowsBackForwardNavigationGesutres instance property of WKWebView / a bool allows backwards forward swiping between web pages
        aViewOfAWebpage.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }

    @objc func openWhatMyUserTapped() {
        // UIAlertController, a class // object that is a part of an object group known collectively as windows and scenes, inherents from UIViewController, used to configure alerts and action sheets
        let alertcontroller = UIAlertController(title: "open webpage", message: nil, preferredStyle: .actionSheet)
        // UIAlertAction is an instance method of UIAlertController
        // note for later: take the title and replace it with bitch and then create a diction and use those titles as keys in the website with the values of the current titles (the websites)
        alertcontroller.addAction(UIAlertAction(title: "shawndimpfl.com", style: .default, handler: openWebpage))
        alertcontroller.addAction(UIAlertAction(title: "audreysmonsters.com", style: .default, handler: openWebpage))
        // .cancel is an enum case
        alertcontroller.addAction(UIAlertAction(title: "cancel", style: .cancel))
        // .popoverPresentationController is an instance property of UIViewController
        alertcontroller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        // present an instance method of UIViewController that presents a view controller modally
        present(alertcontroller, animated: true)
    }
    
    func openWebpage(action: UIAlertAction) {
        let theURLOfTheWebsiteThatWeWantToOpen = URL(string: "https//" + action.title!)!
        aViewOfAWebpage.load(URLRequest(url: theURLOfTheWebsiteThatWeWantToOpen))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = aViewOfAWebpage.title
    }

}


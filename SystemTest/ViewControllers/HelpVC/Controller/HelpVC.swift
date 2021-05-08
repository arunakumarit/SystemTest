//
//  HelpVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit
import WebKit

class HelpVC: BaseViewController {

    @IBOutlet weak var helpWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            let revealButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = revealButtonItem
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        helpWebView.navigationDelegate = self
        self.navigationItem.title = "Help"
        if let url = URL(string: "https://openweathermap.org/api") {
            let request = URLRequest(url: url as URL)
            helpWebView.load(request)
        }
        
    }

}
extension HelpVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showHUD(title: "Loading...")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       self.hideHud()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
}

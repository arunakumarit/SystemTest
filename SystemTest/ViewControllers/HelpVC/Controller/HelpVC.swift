//
//  HelpVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class HelpVC: BaseViewController {

    @IBOutlet weak var helpWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            let revealButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = revealButtonItem
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        self.navigationItem.title = "Help"
        if let url = URL(string: "https://openweathermap.org/api") {
            let request = URLRequest(url: url as URL)
            helpWebView.loadRequest(request)
        }
        
    }

}
extension HelpVC: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showHUD(title: "Loading...")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        print ("error has occured.")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.hideHud()

    }
}

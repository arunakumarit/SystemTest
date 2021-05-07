//
//  LocationCell.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingHud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showAlert(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
// MARK: - Adding MBProgress HUD
extension BaseViewController {
    func showHUD(title: String?, detailText: String = "") {
        resetLoadingView()
        loadingHud = MBProgressHUD.showAdded(to: view, animated: true)
        loadingHud?.mode = MBProgressHUDMode.indeterminate
        loadingHud?.detailsLabel.text = detailText
        loadingHud?.label.text = title
    }
    
    func showHUDProgress(value: String) {
        loadingHud?.detailsLabel.text = value
    }
    private func resetLoadingView() {
        if loadingHud == nil {
            loadingHud = MBProgressHUD()
        }
        loadingHud?.removeFromSuperview()
        loadingHud?.hide(animated: true)
    }
    func hideHud() {
        self.resetLoadingView()
        loadingHud?.hide(animated: true)
    }
}

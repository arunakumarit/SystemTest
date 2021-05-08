//
//  MetricImperialVC.swift
//  SystemTest
//
//  Created by tummaa1 on 08/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class MetricImperialVC: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLbl: UILabel!
    
    var convertStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segControl.selectedSegmentIndex = 0
        convertStr = "metric"
        self.navigationItem.title = "Metric/Imperial"
        if self.revealViewController() != nil {
            let revealButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = revealButtonItem
            navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        self.addDoneButtonOnKeyboard()

    }

    @IBAction func metricImperialSegAction(_ sender: UISegmentedControl) {
        if segControl.selectedSegmentIndex == 0 {
            convertStr = "metric"
        }else if segControl.selectedSegmentIndex == 1 {
            convertStr = "imperial"
        }
    }
    @IBAction func convertBtnActtion(_ sender: UIButton) {
        self.metricImperialConvertion()
    }
    func metricImperialConvertion() {
        if convertStr == "metric" {
            let formatter = MeasurementFormatter()
            let distanceInMiles = Measurement(value: Double(inputTextField.text ?? "") ?? 0.0, unit: UnitLength.miles)
            UserDefaults.standard.set("en_FR", forKey: "locale")
            let localeIdentifier = UserDefaults.standard.object(forKey: "locale") ?? "en_FR"
            let locale = Locale(identifier: localeIdentifier as! String)
            formatter.locale = locale
            print(formatter.string(from: distanceInMiles))
            self.resultLbl.text = "Result: \(formatter.string(from: distanceInMiles))"
            
        }else if convertStr == "imperial" {
            let testInch : Measurement = Measurement(value: Double(inputTextField.text ?? "") as! Double, unit: UnitLength.inches)
            print(testInch)
            self.resultLbl.text = "Result: \(testInch)"
            
        }
    }
}

extension UnitLength {
    static var imperial: UnitLength {
        switch self.baseUnit() {
        case centimeters:
            return UnitLength.inches
        case meters:
            return UnitLength.feet
        default:
            return UnitLength.inches
        }
    }
}
extension MetricImperialVC {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.flexibleSpace,
                                        target: nil,
                                        action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputTextField.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction() {
        self.inputTextField.resignFirstResponder()
       self.metricImperialConvertion()
    }
}

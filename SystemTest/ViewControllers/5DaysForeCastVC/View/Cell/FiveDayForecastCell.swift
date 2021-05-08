//
//  5DayForecastCell.swift
//  SystemTest
//
//  Created by tummaa1 on 08/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

class FiveDayForecastCell: UITableViewCell {

    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var degLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

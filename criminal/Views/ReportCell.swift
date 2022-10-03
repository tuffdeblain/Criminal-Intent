//
//  ReportCell.swift
//  criminal
//
//  Created by Сергей Кудинов on 02.10.2022.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var dateOfCrimeLabel: UILabel!
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var photoOfCrime: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

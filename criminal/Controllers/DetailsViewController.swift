//
//  DetailsViewController.swift
//  criminal
//
//  Created by Сергей Кудинов on 02.10.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var dateOfCrimeLabel: UILabel!
    @IBOutlet weak var isSolvedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOfCrime: UIImageView!
    
    var dateOfCrime = ""
    var isSolved = false
    var titleOfCrime = ""
    var image: Data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateOfCrimeLabel.text = dateOfCrime
        isSolvedLabel.text = String(isSolved)
        titleLabel.text = titleOfCrime
        imageOfCrime.image = UIImage(data: image)
        // Do any additional setup after loading the view.
    }
    
}

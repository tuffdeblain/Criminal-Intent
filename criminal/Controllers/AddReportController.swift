//
//  ViewController.swift
//  criminal
//
//  Created by Сергей Кудинов on 01.10.2022.
//

import UIKit
import CoreData

class AddReportController: UIViewController {
    var picker:UIImagePickerController?=UIImagePickerController()
    var imageData: Data = Data()
 
    @IBOutlet weak var solvedSwitch: UISwitch!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var photoOfCrime: UIImageView!
    @IBOutlet weak var dateOfCrimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveReportAction() {
        saveReport()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoAction() {
        addNewPerson()
    }
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)

    }
    
}

extension AddReportController: UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    func saveReport() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Report", in: context) else {return}
        let report = Report(entity: entity, insertInto: context)
        report.title = titleTextField.text
        report.solved = solvedSwitch.isOn
        report.dateOfCrime = dateOfCrimeLabel.text
        report.imageData = imageData
        do {
            try context.save()
            
        } catch {
            print(error)
        }
        
    }
    
    func setupView() {
        if photoOfCrime.image == nil {
            photoOfCrime.image = UIImage(systemName: "questionmark")
        } else {
            
        }
        
        let dateOfCrime = Date.now
        dateOfCrimeLabel.text = dateOfCrime.formatted()
        
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            photoOfCrime.image = UIImage(data: jpegData)
            imageData = jpegData
            try? jpegData.write(to: imagePath)
        }

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

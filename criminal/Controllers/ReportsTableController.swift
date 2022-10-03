//
//  ReportsTableController.swift
//  criminal
//
//  Created by Сергей Кудинов on 02.10.2022.
//
import CoreData
import UIKit

class ReportsTableController: UITableViewController {
    var countOfRows = 0
    var reports: [Report] = []
    var selectedRow = 0
    override func viewWillAppear(_ animated: Bool) {
        getReports()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let container = appDelegate.persistentContainer.viewContext

            let commit = reports[indexPath.row]
            container.delete(commit)
            reports.remove(at: indexPath.row)
            
            
            do {
                try container.save()
                getReports()
            } catch {
                print("error")
            }
                        
        }
            
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let path = tableView.indexPathForSelectedRow?.row
        if let destination = segue.destination as? DetailsViewController {
            destination.dateOfCrime = reports[path!].dateOfCrime ?? ""
            destination.image = reports[path!].imageData ?? Data()
            destination.isSolved = reports[path!].solved ?? false
            destination.titleOfCrime = reports[path!].title ?? ""
        }
        
            
       
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue", sender: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ReportCell
        cell.crimeLabel.text = reports[indexPath.row].title
        cell.dateOfCrimeLabel.text = reports[indexPath.row].dateOfCrime
        if (reports[indexPath.row].imageData == nil) {
            cell.photoOfCrime.image = UIImage(systemName: "questionmark")
        } else {
            cell.photoOfCrime.image = UIImage(data: reports[indexPath.row].imageData!)
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        71
    }
    func getReports() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Report> =   Report.fetchRequest()
        do {
            let reports = try container.fetch(fetchRequest)
            self.reports = reports
            countOfRows = reports.count
            tableView.reloadData()
        } catch let error as NSError{
            print(error.localizedDescription)
            
        }
    }
}

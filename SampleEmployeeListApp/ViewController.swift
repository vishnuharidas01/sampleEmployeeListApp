//
//  ViewController.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 04/06/22.
//

import UIKit
import Foundation
class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var employeeTableView: UITableView!
    
    var employeeDetailArray: [Employee] = []
    var tabledata: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        CoreDataController.fetchAllEmployees() { employees in
          
            guard let employeeList = employees else {
                ApiCalls().getEmployeeDetailList() { employeeData in
                    self.employeeDetailArray = employeeData
                    self.tabledata = employeeData
                    self.reloadTable()
                }
                return
            }
            self.employeeDetailArray = employeeList
            self.tabledata = employeeList
            self.reloadTable()
        }
        
//        ApiCalls().getEmployeeDetailList() { employeeData in
//            self.employeeDetailArray = employeeData
//            self.reloadTable()
//        }
        
        
    }
   
    private func reloadTable(){
        DispatchQueue.main.async {
            self.employeeTableView.reloadData()
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoEmployeeDetail", let data = sender as? Employee {
            let destination = segue.destination as? EmployeeDetailViewController
            
            destination?.employeeDetail = data
            
        }
    }

}



// MARK: - TableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabledata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeListTableViewCell.id, for: indexPath) as! EmployeeListTableViewCell
        
        cell.data = tabledata[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? EmployeeListTableViewCell
        
        performSegue(withIdentifier: "gotoEmployeeDetail", sender: cell?.data)
    }
    
}


// Search Bar

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            tabledata = employeeDetailArray
        } else {
            tabledata = employeeDetailArray.filter { employee in
                let searchResult = employee.name?.lowercased().contains(searchText.lowercased()) ?? false || employee.email?.lowercased().contains(searchText.lowercased()) ?? false
                return searchResult
            }
        }
        self.reloadTable()
      
    }
    
    
    
}

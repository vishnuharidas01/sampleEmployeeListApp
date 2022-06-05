//
//  EmployeeDetailViewController.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 05/06/22.
//

import Foundation
import UIKit
import Kingfisher

class EmployeeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UITextView!
    
    
    var employeeDetail: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = employeeDetail?.name ?? ""
        setUpView()
    }
    
    
    
    func setUpView() {
        
        guard let employee = employeeDetail else {
            return
        }
        
        if let imageUrlString = employee.profile_image, let imageUrl = URL(string: imageUrlString) {
            profileImageView.kf.setImage(with: imageUrl)
        }
        nameLabel.text = employee.name ?? "-"
        userNameLabel.text = employee.username ?? "-"
        emailLabel.text = employee.email ?? "-"
        
        let street = employee.address?.street ?? "-"
        let suite = employee.address?.suite ?? "-"
        let city = employee.address?.city ?? "-"
        let zipcode = employee.address?.zipcode ?? "-"
        addressTextField.text = street + "\n" + suite + "\n" + city + "\n"  + zipcode
       // addressTextField.text = employee.address
        phoneLabel.text = employee.phone ?? "-"
        websiteLabel.text = employee.website ?? "-"
        
        let companyname = employee.company?.name ?? "-"
        let catchPhrase = employee.company?.catchPhrase ?? "-"
        let bs = employee.company?.bs ?? "-"
        companyAddressLabel.text =  companyname + "\n" + catchPhrase + "\n" + bs
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            
            if let destination = segue.destination as? MapViewController, let employee = employeeDetail, let lat = employee.address?.geo?.lat, let lng = employee.address?.geo?.lng {
                
                destination.lat = lat
                destination.lng = lng
            }
        }
    }
    
    @IBAction func gotoMapView(_ sender: Any) {
        
        performSegue(withIdentifier: "showMap", sender: nil)
    }
}

//
//  EmployeeListtableViewCell.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 05/06/22.
//

import UIKit
import Kingfisher

class EmployeeListTableViewCell: UITableViewCell {
    
    static let id = "EmployeeListTableViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    var data: Employee? {
        didSet {
            userNameLabel.text = data?.name ?? ""
            companyNameLabel.text =  data?.company?.name
            let url = URL(string: data?.profile_image ?? "")
            profileImageView.kf.setImage(with: url)
        }
    }
}

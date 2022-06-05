//
//  Employee.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 04/06/22.
//

import Foundation


struct Employee: Codable {
    let id: Int?
    var name: String?
    var username: String?
    var email: String?
    var profile_image: String?
    var address: AddressDetails?
    var company: CompanyDetails?
    var phone: String?
    var website: String?
}

struct AddressDetails: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: LocationData?
    
 

}

struct LocationData: Codable {
    var lat = ""
    var lng = ""
    
}

struct CompanyDetails: Codable {
    var name = ""
    var catchPhrase = ""
    var bs = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
        }
}

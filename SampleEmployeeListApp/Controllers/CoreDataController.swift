//
//  CoreDataController.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 05/06/22.
//

import CoreData
import UIKit


class CoreDataController: NSObject {
    
    func saveEmployeeToDB(_ employeeData: [Employee]) {
        guard let appdelegate = UIApplication.shared.delegate  as? AppDelegate else {
            return print("No app Delegate")
        }
        let context = appdelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "EmployeeDetails", in: context) else {
            return print("no entity Found")
        }
        
        for employeeDatum in employeeData {
            let datum = NSManagedObject(entity: entity, insertInto: context)
            
           
            let city = employeeDatum.address?.city ?? "-"
            let street = employeeDatum.address?.street ?? "-"
            let suite = employeeDatum.address?.suite ?? "-"
            let zipcode = employeeDatum.address?.zipcode ?? "-"
            let lat = employeeDatum.address?.geo?.lat ?? ""
            let long = employeeDatum.address?.geo?.lng ?? ""
            let companyname = employeeDatum.company?.name ?? "-"
            let catchPhrase = employeeDatum.company?.catchPhrase ?? "-"
            let bs = employeeDatum.company?.bs ?? "-"
            
            
            datum.setValue("\(employeeDatum.id ?? 0)", forKey: "id")
            datum.setValue(employeeDatum.name ?? "-", forKey: "name")
            datum.setValue(employeeDatum.username ?? "-", forKey: "username")
            datum.setValue(employeeDatum.email ?? "-", forKey: "email")
            datum.setValue(employeeDatum.profile_image ?? "-", forKey: "profileImage")
            datum.setValue(street + "\n" + suite + "\n" + city + "\n"  + zipcode, forKey: "address")
            datum.setValue(lat, forKey: "lat")
            datum.setValue(long, forKey: "long")
            datum.setValue(companyname + "\n" + catchPhrase + "\n" + bs, forKey: "company")
            datum.setValue(employeeDatum.phone ?? "-", forKey: "phone")
            datum.setValue(employeeDatum.website ?? "-", forKey: "website")
            
            do {
                try context.save()
                print("Sucess")
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        
        
    }
    
    
    class func fetchAllEmployees(completion : @escaping ([Employee]?) -> Void) {
        
        let delegate = UIApplication.shared.delegate  as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeDetails")
        var employee: [Employee] = []
        request.returnsObjectsAsFaults = false
        do {
            let employeeArray: [NSManagedObject] = try  context?.fetch(request) as? [NSManagedObject] ?? []
            if !employeeArray.isEmpty {
                for employeeData in employeeArray {
                  
                    let id = employeeData.value(forKey: "id") as? String
                    let name = employeeData.value(forKey: "name") as? String
                    let username = employeeData.value(forKey: "username") as? String
                    let email = employeeData.value(forKey: "email") as? String
                    let profileImage = employeeData.value(forKey: "profileImage") as? String
                    let address = employeeData.value(forKey: "address") as? String
                    let lat = employeeData.value(forKey: "lat") as? String
                    let long = employeeData.value(forKey: "long") as? String
                    let company = employeeData.value(forKey: "company") as? String
                    let phone = employeeData.value(forKey: "phone") as? String
                    let website = employeeData.value(forKey: "website") as? String
                    
                    let geodata = LocationData(lat: lat ?? "", lng: long ?? "")
                    let addressDetail = AddressDetails(street: String("\(address?.split(separator: "\n")[0] ?? "")"), suite: String("\(address?.split(separator: "\n")[1] ?? "")"), city: String("\(address?.split(separator: "\n")[2] ?? "")"), zipcode: String("\(address?.split(separator: "\n")[3] ?? "")"), geo: geodata)
                    
                    let companyDetails = CompanyDetails(name: String("\(company?.split(separator: "\n")[0] ?? "")"), catchPhrase: String("\(company?.split(separator: "\n")[1] ?? "")"), bs: String("\(company?.split(separator: "\n")[2] ?? "")"))
               let employeeToAdd = Employee(id: Int(id ?? ""), name: name, username: username, email: email, profile_image: profileImage, address: addressDetail, company: companyDetails, phone: phone, website: website)
                    
                    employee.append(employeeToAdd)
            }
                completion(employee)
            } else {
                completion(nil)
            }
        
        } catch {
            completion(nil)
        }
    }
}

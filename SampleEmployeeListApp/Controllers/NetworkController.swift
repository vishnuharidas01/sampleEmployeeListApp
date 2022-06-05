//
//  NetworkController.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 04/06/22.
//

import Foundation
import Alamofire


struct ApiCalls {
    
    func getEmployeeDetailList(completion: @escaping ([Employee]) -> Void) {
       
        guard let urlFromString = URL(string: "http://www.mocky.io/v2/5d565297300000680030a986") else {
            return
        }
        
        AF.request(urlFromString, method: .get).responseJSON { response in
            
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let responseData =  try decoder.decode([Employee].self, from: data)
                        CoreDataController().saveEmployeeToDB(responseData)
                        completion(responseData)
                    } catch {
                        completion([])
                        print("Api response parsing error:\(error)")
                    }
                }
                
            case .failure:
                completion([])
                return
            }
            
        }
    }
}

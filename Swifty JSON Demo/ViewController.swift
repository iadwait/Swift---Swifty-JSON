//
//  ViewController.swift
//  Swifty JSON Demo
//
//  Created by Adwait Barkale on 16/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//https://jsonplaceholder.typicode.com/users

class ViewController: UIViewController {
    
    var arrDataModel = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnGetDataTapped(_ sender: UIButton) {
        getApiData()
    }
    
    
    func getApiData()
    {
        //Parsing All Object Data
        
        
        AF.request("https://jsonplaceholder.typicode.com/users").responseJSON { (response) in
            
            switch response.result
            {
            case .success(let value):
                //print(value)
                let jsonObj = JSON(value)
                //print("JSON OBJECT - \(jsonObj)")
                self.parseJSON(jsonData: jsonObj)
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func parseJSON(jsonData: JSON)
    {
        let dataModel = DataModel()
        let addressModel = AddressModel()
        var arrayDataModel = [DataModel]()
        
        for obj in 0..<jsonData.count
        {
            
            let currentObj = jsonData[obj]
            
            if let id = currentObj["id"].string
            {
                dataModel.id = id
            }
            
            if let name = currentObj["name"].string
            {
                dataModel.name = name
            }
            
            if let userName = currentObj["username"].string
            {
                dataModel.username = userName
            }
            
            if let email = currentObj["email"].string
            {
                dataModel.email = email
            }
            
            let currentAddress = jsonData[obj]["address"]
            
            if let city = currentAddress["city"].string
            {
                addressModel.city = city
            }
            
            if let suite = currentAddress["suite"].string
            {
                addressModel.suite = suite
            }
            
            if let street = currentAddress["street"].string
            {
                addressModel.street = street
            }
            
            dataModel.address = addressModel
            
            arrayDataModel.append(dataModel)
            print(arrayDataModel.count)
        }
        
        self.arrDataModel = arrayDataModel
    }
    
}


class DataModel
{
    var id = String()
    var name = String()
    var username = String()
    var email = String()
    var address = AddressModel()
}

class AddressModel
{
    var city = String()
    var suite = String()
    var street = String()
}

/*
 //Parsing Single Object Data
 let addressJSON = jsonObj[0]["address"]
 //print("Address JSON = \(addressJSON)")
 
 let addressObj = AddressModel()
 
 if let city = addressJSON["city"].string
 {
 addressObj.city = city
 }
 
 if let street = addressJSON["street"].string
 {
 addressObj.street = street
 }
 
 if let suite = addressJSON["suite"].string
 {
 addressObj.suite = suite
 }
 
 print("Address Object Details")
 print("City - \(addressObj.city)")
 print("Street - \(addressObj.street)")
 print("Suite - \(addressObj.suite)")
 */

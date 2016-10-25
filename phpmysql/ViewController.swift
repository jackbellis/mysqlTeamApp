//
//  ViewController.swift
//  phpmysql
//
//  Created by Jack Bellis on 10/20/16.
//  Copyright © 2016 Jack Bellis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //URL to our web service
    //let URL_SAVE_TEAM = "http://192.168.1.103/MyWebService/api/createteam.php"
    //let URL_SAVE_TEAM = "http://localhost/MyWebServices/includes/createteam.php" //works in simulator, not phone
    //let URL_SAVE_TEAM = "http://145.36.81.35/MyWebServices/api/createteam.php" didnt help for phone
    let URL_SAVE_TEAM = "http://www.backto2billion.com/MyWebServices/api/createteam.php"
    //ifconfig 145.36.81.35
    
    //TextFields declarations
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMember: UITextField!
    
    
    //Button action method
    @IBAction func buttonSave(sender: UIButton) {
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(URL: requestURL!)
        
        //setting the method to post
        request.HTTPMethod = "POST"
        
        //getting values from text fields
        let teamName=textFieldName.text
        let memberCount = textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "name="+teamName!+"&member="+memberCount!;
        
        //adding the parameters to request body
        request.HTTPBody = postParameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        //creating a task to send the post request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  SelectUserVC.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 01.06.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase

class SelectUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var uniqueName = ""
    var detail = ""
    var imageURL = ""
    
    var users : [User] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //print(imageURL)
        
        FIRDatabase.database().reference().child("user").observe(.childAdded, with: {
            (snapshot: FIRDataSnapshot) in
            let user = User()
            
            if let dictionary = snapshot.value as? NSDictionary {
                if let userEmail = dictionary["email"] as? String {
                    user.email = userEmail
                    
                    
                }
            }
            
            user.uid = snapshot.key
            self.users.append(user)
            self.tableView.reloadData()
            
        
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let spotDict = ["uniqueName": uniqueName,
                        "imageURL": imageURL,
                        "description": description,
                        "from": FIRAuth.auth()!.currentUser!.email
        ]
        let user = users[indexPath.row]
        
        FIRDatabase.database().reference().child("user").child(user.uid).child("spots").childByAutoId().setValue(spotDict)
        
        navigationController?.popToRootViewController(animated: true) // back to home page after saving
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

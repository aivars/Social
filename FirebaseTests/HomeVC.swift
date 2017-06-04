//
//  HomeVC.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 30.05.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var spots : [Spot] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // fetch data from firebase
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("spots").observe(.childAdded, with: {(snapshot: FIRDataSnapshot ) in
            
            let spot = Spot()
            
            if let dictionary = snapshot.value as? NSDictionary {
                
                if let imgURL = dictionary["imageURL"] as? String{
                    spot.imageURL = imgURL
                }
                
                if let frm = dictionary["from"] as? String{
                    spot.fromUser = frm
                }
                if let desc = dictionary["description"] as? String{
                    spot.detail = desc
                }
                if let uniName = dictionary["uniqueName"] as? String{
                    spot.uniqueName = uniName
                }
                spot.key = snapshot.key
                
                
            }
            
            self.spots.append(spot)
            self.tableView.reloadData()
        
        })
        
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("spots").observe(.childRemoved, with: { (snapshot) in
            var arrayKey = 0
            for spot in self.spots{
                if spot.key == snapshot.key{
                        self.spots.remove(at: arrayKey)
                }
                arrayKey += 1
            }
            
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell ()
        
        let spot = spots[indexPath.row]
        cell.textLabel?.text = spot.uniqueName
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spot = spots[indexPath.row]
        performSegue(withIdentifier: "viewSpotDetail", sender: spot)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSpotDetail"{
            let guest = segue.destination as! spotDetailVC
            guest.spot = sender as! Spot
        
        }
    }
    
    
    
    

   

}

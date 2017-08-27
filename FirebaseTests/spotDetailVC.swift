//
//  spotDetrailVC.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 03.06.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage



class spotDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spotDetails: UILabel!
    @IBOutlet weak var from: UILabel!
    
    var spot = Spot()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.sd_setImage(with: URL(string: spot.imageURL))
        spotDetails.text = spot.detail
        from.text = spot.uniqueName
        
        navigationItem.title = "Spot details"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHideFromList(_ sender: UIButton) {
        //Dleete from database
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("spots").child(spot.key).removeValue()
        
        //delete images from storage
        FIRStorage.storage().reference().child("spotImages").child("\(spot.uniqueName).jpg").delete { (error) in
            print ("\(String(describing: error?.localizedDescription))")
        }
        
        //pop the user to the root VC
        
        navigationController?.popToRootViewController(animated: true)
        
        //reload the table view when child is deleted
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

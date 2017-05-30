//
//  ViewController.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 21.05.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var signView: UIView!
    
    @IBOutlet weak var emailtTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var ref: FIRDatabaseReference?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // SignIn view changes
        signView.layer.cornerRadius = 16
        signView.layer.shadowColor = UIColor.black.cgColor
        signView.layer.shadowOpacity = 1
        signView.layer.shadowRadius = 10
        signView.layer.shadowOffset = CGSize.zero
        
        ref = FIRDatabase.database().reference()
        //
    }

    //White status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    //Hide keyboard on screen touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        
        return true
        
    }
    @IBAction func onLogInButton(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailtTextField.text!, password: PasswordTextField.text!, completion: {(user, error) in
            if error != nil {
                FIRAuth.auth()?.createUser(withEmail: self.emailtTextField.text!, password: self.PasswordTextField.text!, completion:{ (user, error) in
                    if error != nil{
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = error?.localizedDescription
                    }else{
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "New user created."
                        
                        // New user created, log in and create record in the database
                        
                        self.ref?.child("user").childByAutoId().child("email").setValue(user!.email)
                        
                        self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
                        
                    }
                
                
                
                })
            }else{
                // user signed in 
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Sign in success"
                self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
            }
        })
    }



}


//
//  CheckoutViewController.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 29.05.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cardholdeNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var valiDateTextField: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var orderSummary: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.hideKeyboard))
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        ScrollView.addGestureRecognizer(tapGesture)
        
        orderSummary.layer.cornerRadius = 10
        orderSummary.layer.shadowColor = UIColor.black.cgColor
        orderSummary.layer.shadowOpacity = 0.5
        orderSummary.layer.shadowRadius = 5
        orderSummary.layer.shadowOffset = CGSize.zero
        
        
    }
    
   
    
    func hideKeyboard() {
        
        cardholdeNameTextField.resignFirstResponder()
        cardNumberTextField.resignFirstResponder()
        cvcTextField.resignFirstResponder()
        valiDateTextField.resignFirstResponder()
    }
    
    
    
    @IBAction func onSubmitButton(_ sender: UIButton) {
        
        
    }
    
    
    
    // TextField scrolling when start & end edit textFields
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == cardNumberTextField || textField == cardholdeNameTextField || textField == valiDateTextField || textField == cvcTextField{
            ScrollView.setContentOffset( CGPoint (x:0, y:150), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint (x:0, y:0), animated: true)
    }
    
    
    //Hide keyboard on screen touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        
        return true
        
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

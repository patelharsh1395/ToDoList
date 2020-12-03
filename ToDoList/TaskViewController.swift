//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Harsh on 2020-12-03.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var TitleText: UITextField!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var DescriptionText: UITextView!
    
    
    @IBAction func TaskComplitionButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DescriptionText.layer.borderWidth = CGFloat(0.5)
        DescriptionText.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        DescriptionText.layer.cornerRadius = CGFloat(10.0)
        
        // Bar button on keyboard
        
        
        let bar = UIToolbar()
        bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        bar.items = [flexSpace,reset,flexSpace]
        bar.sizeToFit()
        TitleText.inputAccessoryView = bar
        DescriptionText.inputAccessoryView = bar
        
        
        
        
    }
    
    @objc func doneTapped()
    {
        view.endEditing(true)
    }
    
    
    
    

   
   

}

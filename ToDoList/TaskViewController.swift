//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Harsh on 2020-12-03.
//

import UIKit
import RealmSwift
import Realm

class TaskViewController: UIViewController {

    @IBOutlet weak var TitleText: UITextField!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var DescriptionText: UITextView!
    
    @IBAction func TaskComplitionButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print("save button clicked")
        let dataModel = DataModel();
        dataModel.title = TitleText.text ?? "" ;
        if let realm = DataModel.realmObj
        {
            
            do{
                try realm.write {
                    realm.add(dataModel);
                }
            }
            catch{
                print("Couldnt able to add data to database");
            }
           
        }
        else
        {
            print("realm is empty")
        }
        dismiss(animated: true) {
           
        }
        
        
    }
    
    var activeTextField : UITextField?
    var activeTextView : UITextView?
    
    let bar = UIToolbar()
    
    @IBOutlet weak var scrollview: UIScrollView!
    //for dissmissing keyboard on touch of surrounding background
    
    lazy var touchView : UIView = {
        var _touchView = UIView();
     
        _touchView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: view.frame.width, height: view.frame.height) // *************
        _touchView.layer.backgroundColor = CGColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(0))
        _touchView.isUserInteractionEnabled = true
        let tapGresture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard));
        _touchView.addGestureRecognizer(tapGresture);
        
        return _touchView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DescriptionText.layer.borderWidth = CGFloat(0.5)
        DescriptionText.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        DescriptionText.layer.cornerRadius = CGFloat(10.0)
        
        // Bar button on keyboard
        bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dissmissKeyboard))
        bar.items = [flexSpace,reset,flexSpace]
        bar.sizeToFit()
        TitleText.inputAccessoryView = bar
        DescriptionText.inputAccessoryView = bar
        
        // registering Delegate
        TitleText?.delegate = self;
        DescriptionText?.delegate = self;
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardEvents()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        deRegisterKeyboardEvents()
    }
    
    func registerKeyboardEvents()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIWindow.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func deRegisterKeyboardEvents()
    {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardDidShowNotification, object: nil);
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil);
        
    }
    
    @objc func keyboardWillAppear(notification : NSNotification)
    {
        
        self.view.addSubview(touchView)

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
              
            
            //*contenIsset To add more space to the scrollview equals to the size of (Keyboard and toolbar)
            let contentInset : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.size.height, right: 0)
            
            scrollview.contentInset = contentInset
           // scrollview.scrollIndicatorInsets = contentInset
            
            
            // bound is size of screen, irrespective of change in coordinates
            // cgRect is window created to check which view falls inside the area
            var cgRect : CGRect = UIScreen.main.bounds
            
            // window size after keyboard appears
            cgRect.size.height -= keyboardSize.size.height + bar.frame.height;
            
                if let active_field = activeTextField
                {
                    if (!cgRect.contains(active_field.frame))
                    {
                        scrollview.scrollRectToVisible(active_field.frame, animated: true)
                    }
                }
           
            if  activeTextView != nil
            {
                    
                    if(!cgRect.contains(CGPoint(x: activeTextView!.frame.maxX, y: activeTextView!.frame.maxY)))
                    {
                       
                        scrollview.scrollRectToVisible(activeTextView!.frame, animated: true)
                    }
            }
         
        }
        
        
        
        
    }
    @objc func keyboardWillDisappear()
    {
        touchView.removeFromSuperview();
       // scrollview.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
       
        scrollview.contentInset = UIEdgeInsets.zero
    }
    
    @objc func dissmissKeyboard()
    {
        view.endEditing(true)
    }
   
}
extension TaskViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
extension TaskViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextView = textView
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeTextView = nil;
    }
}

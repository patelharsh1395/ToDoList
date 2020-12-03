//
//  ToDoList_ItemsViewController.swift
//  ToDoList
//
//  Created by Harsh on 2020-12-02.
//

import UIKit

class ToDoList_ItemsViewController: UIViewController {

    var arr : [String] = ["Harsh","Patel","Narendra","Sushmit"];
    
    @IBOutlet weak var TableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.dataSource = self;
        self.TableView.delegate = self;
        
    // navigation bar button
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .done, target: nil, action: #selector(addNewToList))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .done, target: nil, action: #selector(editExistingList))
    
       
      
        
        // Do any additional setup after loading the view.
    }
    
    @objc func addNewToList()
    {
        print("add clicked");
    }
    @objc func editExistingList()
    {
        print("edit clicked");
    }
    


}
extension ToDoList_ItemsViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "table_cell") as! CustomTableViewCell;
        
        cell.Title.text  = self.arr[indexPath.row]
        cell.DateOfModification.text  = self.arr[indexPath.row]
        
        return cell;
        
    }
    
    
}

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

        
        
        // Do any additional setup after loading the view.
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

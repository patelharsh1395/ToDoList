//
//  ToDoList_ItemsViewController.swift
//  ToDoList
//
//  Created by Harsh on 2020-12-02.
//

import UIKit
import RealmSwift

class ToDoList_ItemsViewController: UIViewController {

    
    var notificationToken: NotificationToken? = nil
    
    var arr : Results<DataModel>? {
        get {
            if let realm = DataModel.realmObj
            {
                return realm.objects(DataModel.self)
            }
            return nil
        }
    }
    
    
    @IBOutlet weak var TableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.dataSource = self;
        self.TableView.delegate = self;
        
    // navigation bar button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(addNewToList))

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .done, target: self, action: #selector(self.editExistingList))
        
        
        notificationToken = arr?.observe { [weak self] (changes: RealmCollectionChange) in
            
                    switch changes {
                    case .initial:
                        self?.TableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        self?.TableView.reloadData()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.TableView.isEditing = false;
    }
    
    
    @objc func addNewToList()
    {
        performSegue(withIdentifier: "SegueToDetailView", sender: nil);
    }
    @objc func editExistingList()
    {
       
            if(self.TableView.isEditing)
            {
                self.TableView.isEditing = false
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .done, target: nil, action: #selector(editExistingList))

            }
            else
            {
                self.TableView.isEditing = true
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(editExistingList))
               
            }
    }
    


}
extension ToDoList_ItemsViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arr?.count ?? 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "table_cell") as! CustomTableViewCell;
        
        if let model = self.arr?[indexPath.row]
        {
            cell.Title.text  = model.title
            cell.DateOfModification.text  = model.title
        }
        return cell;
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        
            if let realm = DataModel.realmObj
            {
                    if let model = self.arr?[indexPath.row]
                    {
                        do{
                            try realm.write
                            {
                                realm.delete(model)
                            }
                            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                        }
                        catch
                        {
                            print("couldnt able to remove data")
                        }
                    }
                

            }
         
        
     }
    
    
    
    
}

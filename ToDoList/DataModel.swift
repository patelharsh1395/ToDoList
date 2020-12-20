//
//  DataModel.swift
//  ToDoList
//
//  Created by Harsh on 2020-12-16.
//

import Foundation
import RealmSwift
class DataModel: Object
{

  //  @objc dynamic var Dataid = UUID().uuidString
    @objc  dynamic var title : String = ""
    @objc  dynamic var desc : String = ""
    @objc  dynamic var date : Date? = nil
    @objc  dynamic var deadline : Date? = nil
    @objc  dynamic var taskComplitionFlag : Int = 0
    
//    override static func primaryKey() -> String? {
//               return "Dataid"
//    }
    
    
    static var realmObj : Realm? {
        get{
                do
                {
                    let realm = try Realm()
                    return realm;
                }
                catch
                {
                    print("Unexpected error: \(error).")
                    return nil
                }
            }
    }
    
    
    
}

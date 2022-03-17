//
//  WalkthoughVM.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import Foundation
class WalkThoughVM: ObservableObject {
    @Published var rows: [WalkThoughModel] = []
    @Published var countRows: Int = 0
    
    init() {
       //getRecords()
    } 
    
    func getRecords(){
        self.rows = [
            WalkThoughModel(_id: UUID().uuidString, _order: 1, _title: "Lorem Ipsum 1", _description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur,", _imageURL: "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg", _bgColorHex: "", _foregroundColorHex: "", _isActive: true),
            
            WalkThoughModel(_id: UUID().uuidString, _order: 2, _title: "Lorem Ipsum 2", _description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur.", _imageURL: "https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819_1280.jpg", _bgColorHex: "", _foregroundColorHex: "", _isActive: true),
            
            WalkThoughModel(_id: UUID().uuidString, _order: 3, _title: "Lorem Ipsum 3", _description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur", _imageURL: "https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729514_1280.jpg", _bgColorHex: "", _foregroundColorHex: "", _isActive: true),
            
            WalkThoughModel(_id: UUID().uuidString, _order: 4, _title: "Lorem Ipsum 4", _description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur.", _imageURL: "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_1280.jpg", _bgColorHex: "", _foregroundColorHex: "", _isActive: true),
            
            WalkThoughModel(_id: UUID().uuidString, _order: 5, _title: "Lorem Ipsum 5", _description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur.", _imageURL: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg", _bgColorHex: "", _foregroundColorHex: "", _isActive: true),
             
            
        ]
        
        self.countRows = rows.count
    }
}



/*
 
 import Foundation

 class WalkThoughVM: ObservableObject {
     @Published var contentRows: [WalkThoughModel] = []
     @Published var countRow: Int = 0
     
     init() {
        // getRecords()
     }
     
     func getRecords() {
         self.contentRows = []
         var newRecordId = ""
        
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).getCollectionRows { dictionaryRows in
             if let allRows = dictionaryRows {
                 for dictionaryRow in allRows {
                     let rowDataStructure = WalkThoughManager().dictionaryToStructrue(dictionaryRow as! [String : Any])
                    
                     self.contentRows.append(rowDataStructure)
                     if rowDataStructure.order == 99999 {
                         newRecordId = rowDataStructure.id
                     }
                    
                 }
                 self.countRow = self.contentRows.count
                 // set new record to the last order
                 if newRecordId != "" {
                     DispatchQueue.main.async {
                         WalkThoughManager().updateOrder(objectId: newRecordId, newOrder: self.contentRows.count)
                     }
                 }
             }
         }
     }
 }

 class WalkThoughManager {
     var memberVM = MemberVM()
     
     func getRecordByObjectId(objectId: String, completion: @escaping (_ content:WalkThoughModel?) -> Void) {
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).getCollectionRowByObjectId(objectId: objectId, completion: { dictionaryRow in
             if let row = dictionaryRow {
                 let rowDataStructure = self.dictionaryToStructrue(row)
                 completion(rowDataStructure)
                 return
             }
         })
     }
     
     /**===================
      createRecord
      */
     func SaveRecord(
             _id: String,
             _order:Int,
             _titleTH: String,
             _descriptionTH: String,
         
             _imageURL: String,
             _bgColorHex: String,
             _foregroundColorHex: String,
             _isActive:Bool,
             _createdAt: Date, completion: @escaping (_ isCompleted: Bool?) -> Void) {
         
         
         let modelData = WalkThoughModel(_id: _id,
                             _order: _order,
                             _titleTH: _titleTH,
                             _descriptionTH: _descriptionTH,

                             _imageURL: _imageURL,
                             _bgColorHex: _bgColorHex.isEmpty ? kHexBgColor : _bgColorHex,
                             _foregroundColorHex: _foregroundColorHex.isEmpty ? kHexForegroundColor : _foregroundColorHex,
                             _isActive: _isActive,
                             _createdByUser: memberVM.userInfo?.id ?? "" ,
                             _createdByName: memberVM.userInfo?.fullName ?? "",
                             _createdAt: _createdAt,
                             _lastUpdated: Date()
                         )
         
         let dictionaryForm = structureToDictionary(row: modelData)
          
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).SaveToFirebase(objectId: _id, dictionaryRowData: dictionaryForm) { isSuccess in
             completion(false)
         }
     }
     
     func updateOrder(objectId: String, newOrder: Int){
         let someFields = [kOrder : newOrder]
         print("// Updated \(objectId)   newOrder > \(newOrder)")
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).updateSomeFields(objectId: objectId, someFields: someFields) { _ in
         }
     }
     
     func updateByFieldName(objectId: String, fieldName: String, fieldValue: Any , completion : @escaping (_ isUpdated: Bool?) -> Void) {
         
         let someFields = [fieldName : fieldValue]
         print(someFields)
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).updateSomeFields(objectId: objectId, someFields: someFields) { _ in
         }
     }
     
     /**===================
      removeRecord Function
      */
     func removeRecord(objectId: String, completion: @escaping (_ isCompleted:Bool?) -> Void) {
         FirestoreManager<WalkThoughModel>(fCollection: .WalkThough).removeRecord(objectId: objectId) { isSuccess in
             completion(isSuccess)
         }
     }
     
     func structureToDictionary(row: WalkThoughModel) -> [String : Any] {
         return NSDictionary(objects: [row.id,
                                       row.order,
                                       row.titleTH,
                                       row.descriptionTH,
                                       
                                       row.imageURL,
                                       row.bgColorHex,
                                       row.foregroundColorHex,
                                       row.isActive,
                                       row.createdByUser,
                                       row.createdByName,
                                       row.createdAt,
                                       row.lastUpdated
                                     ],
                             forKeys: [
                                 kId as NSCopying,
                                 kOrder as NSCopying,
                                 kTitleTH as NSCopying,
                                 kDescriptionTH as NSCopying,

                                 kimageURL as NSCopying,
                                 kbgColorHex as NSCopying,
                                 kforegroundColorHex as NSCopying,
                                 kisActive as NSCopying,
                                 kCreateByUserId as NSCopying,
                                 kCreateByName as NSCopying,
                                 kCreatedDate as NSCopying,
                                 kLastUpdated as NSCopying
                                 
                                       
         ]) as! [String : Any]
     }
     
     func dictionaryToStructrue(_ row: [String : Any]) -> WalkThoughModel{
         return WalkThoughModel (
                     _id: row[kId] as? String ?? "",
                     _order: row[kOrder] as? Int ?? 0,
                      _titleTH: row[kTitleTH] as? String ?? "",
                      _descriptionTH: row[kDescriptionTH] as? String ?? "",
                        
                      _imageURL: row[kimageURL] as? String ?? "",
                      _bgColorHex: row[kbgColorHex] as? String ?? "",
                      _foregroundColorHex: row[kforegroundColorHex] as? String ?? "",
                      _isActive: row[kisActive]  as? Bool ?? true,
                     _createdByUser: row[kCreateByUserId] as! String,
                     _createdByName: row[kCreateByName] as? String ?? "",
                     _createdAt: row[kCreatedDate] as? Date ?? Date(),
                     _lastUpdated: row[kLastUpdated] as? Date ?? Date()
             
         )
     }
 }

 
 */

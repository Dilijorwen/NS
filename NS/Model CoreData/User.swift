import CoreData

extension User {
    /* Синтаксический сахар*/
    
    var login: String{
        get { login_ ?? String() }
        set { login_ = newValue }
    }
    
    var password: String{
        get { password_ ?? String() }
        set { password_ = newValue }
    }
    
    var token: String{
        get { token_ ?? String() }
        set { token_ = newValue }
    }
    
    var id: Int16 {
        get { id_ }
        set { id_ = Int16(newValue)}
    }
    
    var first_name: String{
        get { first_name_ ?? String() }
        set { first_name_ = newValue }
    }
    
    var last_name: String{
        get { last_name_ ?? String() }
        set { last_name_ = newValue }
    }
    
    var role: String{
        get { role_ ?? String() }
        set { role_ = newValue }
    }
    
    
//    static func fetch()-> NSFetchRequest<Item>{
//        let request = NSFetchRequest<Item>(entityName: "Item")
//        
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp_,
//                                                    ascending: true)]
//        return request
//    }
}

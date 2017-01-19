import UIKit
import os.log

class Meal: NSObject, NSCoding{
    
    // MARK: properties
    var name: String
    var photo: UIImage?
    var rating :Int
    
    // MARK: Archiving path
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals" )
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // The name is must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        guard (0 <= rating) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    // MARK: Types
    
    struct PropertyKeys {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(photo, forKey: PropertyKeys.photo)
        aCoder.encode(rating, forKey: PropertyKeys.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // The name is required. If we cannot decode a name string, the initializer shoud fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKeys.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKeys.rating)
        
        self.init(name: name, photo: photo, rating: rating)
    }

}

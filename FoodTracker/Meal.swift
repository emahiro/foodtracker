import UIKit

class Meal{
    
    // MARK: properties
    var name: String
    var photo: UIImage?
    var rating :Int
    
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
    
    
}

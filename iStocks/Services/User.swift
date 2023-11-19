import Foundation
import UIKit

class User {
    var image: UIImage? = UIImage(named: "unloggedUser")
    var username: String = "unlogged"
    var language: String = "Русский"
    var decoration: String = "Системное"
    var isLogged: Bool = false
}

var user = User()

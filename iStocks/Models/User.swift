import UIKit

enum Language: String, CaseIterable {
    case rus = "Русский"
    case eng = "Английский"
}

enum Theme: String, CaseIterable {
    case light = "Светлое"
    case dark = "Темное"
    case system = "Системное"
}

class User {
    var image: UIImage? = UIImage(named: "unloggedUser")
    var username: String = "unlogged"
    var language: Language = .rus
    var theme: Theme = .system
    var isLogged: Bool = false
}

var user = User()

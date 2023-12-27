import Foundation

protocol UserFavoriteServiceDescription {
    func setFavorite(_ stock: Stock)
    func isFavorite(_ ticker: String) -> Bool
    func delFavorite(_ stock: Stock)
}

final class UserFavoriteService: UserFavoriteServiceDescription {
    private let userDefaults = UserDefaults.standard
    
    static let shared: UserFavoriteServiceDescription = UserFavoriteService()
    private init() {}
    
    func setFavorite(_ stock: Stock) {
        userDefaults.set(true, forKey: stock.ticker)
    }
    
    func isFavorite(_ ticker: String) -> Bool {
        userDefaults.object(forKey: ticker) != nil
    }
    
    func delFavorite(_ stock: Stock) {
        userDefaults.removeObject(forKey: stock.ticker)
    }
}

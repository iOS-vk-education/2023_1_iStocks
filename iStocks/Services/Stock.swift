import UIKit

struct Stock {
    var name: String
    var ticker: String
    var price: Float
    var isFavorite: Bool
    var haveNote: Bool
    var note: String
    var image: UIImage
}

// ТЕСТ
let stocks: [Stock] = [
    Stock(name: "Ozon Holdings PLC", ticker: "OZON", price: 2614.8, isFavorite: true, haveNote: true, note: "cool", image: UIImage(named: "ozon")!),
    Stock(name: "Polymetall", ticker: "POLY", price: 617.6, isFavorite: false, haveNote: true, note: "norm", image: UIImage(named: "poly")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Positive Techologies", ticker: "POSI", price: 278.15, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Polymetall", ticker: "POLY", price: 617.6, isFavorite: false, haveNote: true, note: "norm", image: UIImage(named: "poly")!),
]

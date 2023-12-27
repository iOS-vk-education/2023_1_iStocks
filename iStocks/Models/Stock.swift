import UIKit

class Stock {
    var name: String
    var ticker: String
    var currentPrice: Float
    var openPrice: Float
    var isFavorite: Bool
    var haveNote: Bool
    var note: String
    var image: UIImage
    
    init(name: String, ticker: String, currentPrice: Float, openPrice: Float, isFavorite: Bool, haveNote: Bool, note: String, image: UIImage) {
        self.name = name
        self.ticker = ticker
        self.currentPrice = currentPrice
        self.openPrice = openPrice
        self.isFavorite = isFavorite
        self.haveNote = haveNote
        self.note = note
        self.image = image
    }
}

// ТЕСТ
let stocks: [Stock] = [
    Stock(name: "Ашинский метзавод", ticker: "AMEZ", currentPrice: 75.45, openPrice: 75, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "amez")!),
    Stock(name: "Магнит", ticker: "MGNT", currentPrice: 6323, openPrice: 6300, isFavorite: false, haveNote: true, note: "Подумать над покупкой.", image: UIImage(named: "mgnt")!),
    Stock(name: "МТС", ticker: "MTSS", currentPrice: 262.85, openPrice: 275, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "mtss")!),
    Stock(name: "Polymetal", ticker: "POLY", currentPrice: 395.5, openPrice: 400, isFavorite: false, haveNote: true, note: "Продать поскорее.", image: UIImage(named: "poly")!),
    Stock(name: "Positive Technologies", ticker: "POSI", currentPrice: 2147.8, openPrice: 2150, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!),
    Stock(name: "Роснефть", ticker: "ROSN", currentPrice: 578.85, openPrice: 575, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "rosn")!),
    Stock(name: "Whoosh", ticker: "WUSH", currentPrice: 237.8, openPrice: 250, isFavorite: true, haveNote: true, note: "Усреднить позицию.", image: UIImage(named: "wush")!),
    Stock(name: "Яндекс", ticker: "YNDX", currentPrice: 2594.6, openPrice: 2594.6, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "yndx")!)
]

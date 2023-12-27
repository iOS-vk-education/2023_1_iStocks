import UIKit

class Stock {
    var name: String
    var ticker: String
    var currentPrice: Float
    var openPrice: Float
    var isFavorite: Bool {
        didSet {
            guard oldValue != isFavorite else { return }
            if isFavorite {
                UserFavoriteService.shared.setFavorite(self)
            } else {
                UserFavoriteService.shared.delFavorite(self)
            }
        }
    }
    var haveNote: Bool
    var note: String
    var image: UIImage
    var highPrice: Float
    var lowPrice: Float
    
    init(name: String, ticker: String, currentPrice: Float, openPrice: Float, isFavorite: Bool, haveNote: Bool, note: String, image: UIImage, highPrice: Float, lowPrice: Float) {
        self.name = name
        self.ticker = ticker
        self.currentPrice = currentPrice
        self.openPrice = openPrice
        self.isFavorite = UserFavoriteService.shared.isFavorite(ticker)
        self.haveNote = haveNote
        self.note = note
        self.image = image
        self.highPrice = highPrice
        self.lowPrice = lowPrice
    }
}

// ТЕСТ
let stocks: [Stock] = [
    Stock(name: "Ашинский метзавод", ticker: "AMEZ", currentPrice: 75.45, openPrice: 75, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "amez")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Магнит", ticker: "MGNT", currentPrice: 6323, openPrice: 6300, isFavorite: false, haveNote: true, note: "Подумать над покупкой.", image: UIImage(named: "mgnt")!, highPrice: 100, lowPrice: 69),
    Stock(name: "МТС", ticker: "MTSS", currentPrice: 262.85, openPrice: 275, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "mtss")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Polymetal", ticker: "POLY", currentPrice: 395.5, openPrice: 400, isFavorite: false, haveNote: true, note: "Продать поскорее.", image: UIImage(named: "poly")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Positive Technologies", ticker: "POSI", currentPrice: 2147.8, openPrice: 2150, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "posi")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Роснефть", ticker: "ROSN", currentPrice: 578.85, openPrice: 575, isFavorite: false, haveNote: false, note: "", image: UIImage(named: "rosn")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Whoosh", ticker: "WUSH", currentPrice: 237.8, openPrice: 250, isFavorite: true, haveNote: true, note: "Усреднить позицию.", image: UIImage(named: "wush")!, highPrice: 100, lowPrice: 69),
    Stock(name: "Яндекс", ticker: "YNDX", currentPrice: 2594.6, openPrice: 2594.6, isFavorite: true, haveNote: false, note: "", image: UIImage(named: "yndx")!, highPrice: 100, lowPrice: 69)
]

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
    var highPrice: Float
    var lowPrice: Float
    
    init(name: String, ticker: String, currentPrice: Float, openPrice: Float, isFavorite: Bool, haveNote: Bool, note: String, image: UIImage, highPrice: Float, lowPrice: Float) {
        self.name = name
        self.ticker = ticker
        self.currentPrice = currentPrice
        self.openPrice = openPrice
        self.isFavorite = isFavorite
        self.haveNote = haveNote
        self.note = note
        self.image = image
        self.highPrice = highPrice
        self.lowPrice = lowPrice
    }
}

// ТЕСТ
var stocks: [Stock] = []

import UIKit

class StockViewController: UIViewController {
    
    var stock: Stock?
    
    private lazy var stockView = UIView()
    private lazy var subscribeButton = UIButton()
    private lazy var stockNameLabel = UILabel()
    private lazy var stockPriceLabel = UILabel()
    private lazy var stockLogoImageView = UIImageView()
    private lazy var stockTickerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "viewController")
        
        setUpStockView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpStockView()
    }
    
    private func setUpStockView() {
        view.addSubview(stockView)
        
        stockView.backgroundColor = UIColor(named: "mainCell")
        stockView.layer.borderWidth = 3.25
        stockView.layer.cornerRadius = 23
        stockView.layer.masksToBounds = true
        
        guard let stock = stock else {
            fatalError()
        }
        
        if stock.isFavorite {
            stockView.layer.borderColor = UIColor(named: "mainCellBorderFavorite")?.cgColor
        } else {
            stockView.layer.borderColor = UIColor(named: "mainCellBorder")?.cgColor
        }
        
        stockView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            stockView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stockView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stockView.heightAnchor.constraint(equalToConstant: 93)
        ])
        
        setUpSubscribeButton()
        setUpStockNameLabel()
        setUpStockPriceLabel()
        setUpStockLogoImageView()
        setUpStockTickerLabel()
    }
    
    private func setUpSubscribeButton() {
        stockView.addSubview(subscribeButton)
        
        guard let stock = stock else {
            fatalError()
        }
        
        if stock.isFavorite {
            subscribeButton.setImage(UIImage(named: "unsubscribe"), for: .normal)
        } else {
            subscribeButton.setImage(UIImage(named: "subscribe"), for: .normal)
        }
        
        subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subscribeButton.leadingAnchor.constraint(equalTo: stockView.leadingAnchor, constant: 20),
            subscribeButton.centerYAnchor.constraint(equalTo: stockView.centerYAnchor)
        ])
    }
    
    private func setUpStockNameLabel() {
        stockView.addSubview(stockNameLabel)
        
        guard let stock = stock else {
            fatalError()
        }
        
        stockNameLabel.text = stock.name
        stockNameLabel.textColor = UIColor(named: "notesNoteLabel")
        stockNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockNameLabel.leadingAnchor.constraint(equalTo: subscribeButton.trailingAnchor, constant: 8),
            stockNameLabel.bottomAnchor.constraint(equalTo: stockView.centerYAnchor, constant: 1)
        ])
    }
    
    private func setUpStockPriceLabel() {
        let differencePrice: Float
        let differencePercents: Float
        var priceAccuracy = 2
        var percentsAccuracy = 2
        
        stockView.addSubview(stockPriceLabel)
        
        guard let stock = stock else {
            fatalError()
        }
        
        differencePrice = round((stock.currentPrice - stock.openPrice) * 100) / 100
        differencePercents = round((differencePrice / stock.openPrice) * 100 * 100) / 100
        
        
        stockPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        if Int(differencePrice * 100) % 10 == 0 {
            priceAccuracy = 1
        }
        
        if Int(differencePercents * 100) % 100 == 0 {
            percentsAccuracy = 0
        } else if Int(differencePercents * 100) % 10 == 0 {
            percentsAccuracy = 1
        }
        
        stockPriceLabel.text = String(format: "%+.*f ₽   %+.*f%%", priceAccuracy, differencePrice, percentsAccuracy, abs(differencePercents)).replacingOccurrences(of: ".", with: ",")
        
        if differencePrice == 0 {
            stockPriceLabel.textColor = UIColor(named: "priceStay")
        } else if differencePrice > 0 {
            stockPriceLabel.textColor = UIColor(named: "priceRise")
        } else {
            stockPriceLabel.textColor = UIColor(named: "priceFall")
        }
        
        stockPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockPriceLabel.leadingAnchor.constraint(equalTo: subscribeButton.trailingAnchor, constant: 8),
            stockPriceLabel.topAnchor.constraint(equalTo: stockView.centerYAnchor, constant: 1)
        ])
    }
    
    private func setUpStockLogoImageView() {
        stockView.addSubview(stockLogoImageView)
        
        guard let stock = stock else {
            fatalError()
        }
        
        stockLogoImageView.image = stock.image
        
        stockLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockLogoImageView.topAnchor.constraint(equalTo: stockView.topAnchor, constant: 16),
            stockLogoImageView.trailingAnchor.constraint(equalTo: stockView.trailingAnchor, constant: -20),
            stockLogoImageView.heightAnchor.constraint(equalToConstant: 45),
            stockLogoImageView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpStockTickerLabel() {
        stockView.addSubview(stockTickerLabel)
        
        guard let stock = stock else {
            fatalError()
        }
        
        stockTickerLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        stockTickerLabel.textColor = UIColor(named: "settingsButton")
        stockTickerLabel.text = stock.ticker
        
        
        stockTickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockTickerLabel.topAnchor.constraint(equalTo: stockLogoImageView.bottomAnchor, constant: 4),
            stockTickerLabel.centerXAnchor.constraint(equalTo: stockLogoImageView.centerXAnchor)
        ])
    }
        
    @objc
    func subscribeButtonTapped() {
        guard let stock = stock else {
            fatalError()
        }
        
        stock.isFavorite = !stock.isFavorite
        setUpStockView()
    }
}

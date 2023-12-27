import UIKit

class StockViewController: UIViewController {
    
    var stock: Stock
    
    private lazy var stockView = UIView()
    private lazy var subscribeButton = UIButton()
    private lazy var stockNameLabel = UILabel()
    private lazy var stockPriceLabel = UILabel()
    private lazy var stockLogoImageView = UIImageView()
    private lazy var stockTickerLabel = UILabel()
    
    init (stock: Stock) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "first")
        
        setUpStockView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpStockView()
    }
    
    private func setUpStockView() {
        view.addSubview(stockView)
        
        stockView.backgroundColor = UIColor(named: "second")
        stockView.layer.borderWidth = 3.25
        stockView.layer.cornerRadius = 23
        stockView.layer.masksToBounds = true
        
        
        if stock.isFavorite {
            stockView.layer.borderColor = UIColor(named: "mainAccentColor")?.cgColor
        } else {
            stockView.layer.borderColor = UIColor(named: "seventh")?.cgColor
        }
        
        stockView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            stockView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stockView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stockView.heightAnchor.constraint(equalToConstant: 93)
        ])
        
        setUpStockLogoImageView()
        setUpStockTickerLabel()
        setUpStockNameLabel()
        setUpStockPriceLabel()
        setUpSubscribeButton()
    }
    
    private func setUpStockLogoImageView() {
        stockView.addSubview(stockLogoImageView)

        stockLogoImageView.image = stock.image
        
        stockLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockLogoImageView.topAnchor.constraint(equalTo: stockView.topAnchor, constant: 16),
            stockLogoImageView.leadingAnchor.constraint(equalTo: stockView.leadingAnchor, constant: 20),
            stockLogoImageView.heightAnchor.constraint(equalToConstant: 45),
            stockLogoImageView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpStockTickerLabel() {
        stockView.addSubview(stockTickerLabel)
        
        stockTickerLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        stockTickerLabel.textColor = UIColor(named: "sixth")
        stockTickerLabel.text = stock.ticker
        
        
        stockTickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockTickerLabel.topAnchor.constraint(equalTo: stockLogoImageView.bottomAnchor, constant: 4),
            stockTickerLabel.centerXAnchor.constraint(equalTo: stockLogoImageView.centerXAnchor)
        ])
    }
    
    private func setUpStockNameLabel() {
        stockView.addSubview(stockNameLabel)
        
        stockNameLabel.text = stock.name
        stockNameLabel.textColor = UIColor(named: "eighth")
        stockNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockNameLabel.leadingAnchor.constraint(equalTo: stockLogoImageView.trailingAnchor, constant: 15),
            stockNameLabel.bottomAnchor.constraint(equalTo: stockView.centerYAnchor, constant: 1)
        ])
    }
    
    private func setUpStockPriceLabel() {
        let differencePrice: Float
        let differencePercents: Float
        var priceAccuracy = 2
        var percentsAccuracy = 2
        
        stockView.addSubview(stockPriceLabel)
        
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
        
        stockPriceLabel.text = String(format: "%+.*f ₽   %.*f%%", priceAccuracy, differencePrice, percentsAccuracy, abs(differencePercents)).replacingOccurrences(of: ".", with: ",")
        
        if differencePrice == 0 {
            stockPriceLabel.textColor = UIColor(named: "sixth")
        } else if differencePrice > 0 {
            stockPriceLabel.textColor = UIColor(named: "green")
        } else {
            stockPriceLabel.textColor = UIColor(named: "red")
        }
        
        stockPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockPriceLabel.leadingAnchor.constraint(equalTo: stockLogoImageView.trailingAnchor, constant: 15),
            stockPriceLabel.topAnchor.constraint(equalTo: stockView.centerYAnchor, constant: 1)
        ])
    }
    
    private func setUpSubscribeButton() {
        stockView.addSubview(subscribeButton)
        
        if stock.isFavorite {
            subscribeButton.setImage(UIImage(named: "unsubscribe"), for: .normal)
        } else {
            subscribeButton.setImage(UIImage(named: "subscribe"), for: .normal)
        }
        
        subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subscribeButton.trailingAnchor.constraint(equalTo: stockView.trailingAnchor, constant: -20),
            subscribeButton.centerYAnchor.constraint(equalTo: stockView.centerYAnchor),
            subscribeButton.heightAnchor.constraint(equalToConstant: 30),
            subscribeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    func subscribeButtonTapped() {        
        stock.isFavorite = !stock.isFavorite
        setUpStockView()
    }
}

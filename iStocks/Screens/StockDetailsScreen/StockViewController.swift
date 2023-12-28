import UIKit

class StockViewController: UIViewController {
    
    var stock: Stock
    
    private lazy var stockView = UIView()
    private lazy var subscribeButton = UIButton()
    private lazy var stockNameLabel = UILabel()
    private lazy var stockPriceLabel = UILabel()
    private lazy var stockLogoImageView = UIImageView()
    private lazy var stockTickerLabel = UILabel()
    
    private lazy var torgDataLabel = UILabel()
    private lazy var openPriceLabel = UILabel()
    private lazy var openPriceMoneyLabel = UILabel()
    private lazy var highPriceLabel = UILabel()
    private lazy var highPriceMoneyLabel = UILabel()
    private lazy var lowPriceLabel = UILabel()
    private lazy var lowPriceMoneyLabel = UILabel()
    private lazy var changePriceLabel = UILabel()
    private lazy var changePriceMoneyLabel = UILabel()
    
    private lazy var paperParamLabel = UILabel()
    private lazy var tickerPresentLabel = UILabel()
    private lazy var tickerNameLabel = UILabel()
    private lazy var currencyPresentLabel = UILabel()
    private lazy var currencyNameLabel = UILabel()
    
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
        
        /* Торговые данные */
        setUpTorgDataLabel()
        setUpOpenPriceLabel()
        setUpOpenPriceMoneyLabel()
        setUpHighPriceLabel()
        setUpHighPriceMoneyLabel()
        setUpLowPriceLabel()
        setUpLowPriceMoneyLabel()
        setUpChangePriceLabel()
        setUpChangePriceMoneyLabel()
        
        /* Параметры бумаги */
        setUpPaperParamLabel()
        setUpTickerPresentLabel()
        setUpTickerNameLabel()
        setUpCurrencyPresentLabel()
        setUpCurrencyNameLabel()
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
    
    private func setUpTorgDataLabel() {
        view.addSubview(torgDataLabel)
        
        torgDataLabel.text = "Торговые данные"
        torgDataLabel.textColor = UIColor(named: "sixth")
        torgDataLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        torgDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            torgDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            torgDataLabel.topAnchor.constraint(equalTo: stockView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setUpOpenPriceLabel() {
        view.addSubview(openPriceLabel)
        
        openPriceLabel.text = "Цена открытия"
        openPriceLabel.textColor = UIColor(named: "sixth")
        openPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        openPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            openPriceLabel.topAnchor.constraint(equalTo: torgDataLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpOpenPriceMoneyLabel() {
        view.addSubview(openPriceMoneyLabel)
        
        openPriceMoneyLabel.text = String(format: "%.*f ₽", stock.openPrice)
        openPriceMoneyLabel.textColor = UIColor(named: "fifth")
        openPriceMoneyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        openPriceMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openPriceMoneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            openPriceMoneyLabel.topAnchor.constraint(equalTo: torgDataLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpHighPriceLabel() {
        view.addSubview(highPriceLabel)
        
        highPriceLabel.text = "Максимальная цена:"
        highPriceLabel.textColor = UIColor(named: "sixth")
        highPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        highPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            highPriceLabel.topAnchor.constraint(equalTo: openPriceLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpHighPriceMoneyLabel() {
        view.addSubview(highPriceMoneyLabel)
        
        highPriceMoneyLabel.text = String(format: "%.*f ₽", stock.highPrice)
        highPriceMoneyLabel.textColor = UIColor(named: "fifth")
        highPriceMoneyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        highPriceMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highPriceMoneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            highPriceMoneyLabel.topAnchor.constraint(equalTo: openPriceLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpLowPriceLabel() {
        view.addSubview(lowPriceLabel)
        
        lowPriceLabel.text = "Минимальная цена:"
        lowPriceLabel.textColor = UIColor(named: "sixth")
        lowPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        lowPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            lowPriceLabel.topAnchor.constraint(equalTo: highPriceLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpLowPriceMoneyLabel() {
        view.addSubview(lowPriceMoneyLabel)
        
        lowPriceMoneyLabel.text = String(format: "%.*f ₽", stock.lowPrice)
        lowPriceMoneyLabel.textColor = UIColor(named: "fifth")
        lowPriceMoneyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        lowPriceMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowPriceMoneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            lowPriceMoneyLabel.topAnchor.constraint(equalTo: highPriceLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpChangePriceLabel() {
        view.addSubview(changePriceLabel)
        
        changePriceLabel.text = "Изменение за день:"
        changePriceLabel.textColor = UIColor(named: "sixth")
        changePriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        changePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changePriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            changePriceLabel.topAnchor.constraint(equalTo: lowPriceLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpChangePriceMoneyLabel() {
        var priceAccuracy = 2
        var percentsAccuracy = 2
        view.addSubview(changePriceMoneyLabel)
        
        let differencePrice: Float = round((stock.currentPrice - stock.openPrice) * 100) / 100
        let differencePercents: Float = round((differencePrice / stock.openPrice) * 100 * 100) / 100
        
        if Int(differencePrice * 100) % 10 == 0 { priceAccuracy = 1 }
        
        percentsAccuracy = Int(differencePercents * 100) % 100 == 0 ? 0 : Int(differencePercents * 100) % 10 == 0 ? 1 : percentsAccuracy
        
        changePriceMoneyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        changePriceMoneyLabel.text = String(format: "%+.*f ₽   %.*f%%", priceAccuracy, differencePrice, percentsAccuracy, abs(differencePercents)).replacingOccurrences(of: ".", with: ",")
        
        changePriceMoneyLabel.textColor = UIColor(named: differencePrice == 0 ? "sixth" : differencePrice > 0 ? "green" : "red")
        
        changePriceMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changePriceMoneyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            changePriceMoneyLabel.topAnchor.constraint(equalTo: lowPriceLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpPaperParamLabel() {
        view.addSubview(paperParamLabel)
        
        paperParamLabel.text = "Параметры бумаги"
        paperParamLabel.textColor = UIColor(named: "sixth")
        paperParamLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        paperParamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            paperParamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            paperParamLabel.topAnchor.constraint(equalTo: changePriceLabel.bottomAnchor, constant: 15)
        ])
    }
    
    private func setUpTickerPresentLabel() {
        view.addSubview(tickerPresentLabel)
        
        tickerPresentLabel.text = "Код бумаги:"
        tickerPresentLabel.textColor = UIColor(named: "sixth")
        tickerPresentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        tickerPresentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerPresentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            tickerPresentLabel.topAnchor.constraint(equalTo: paperParamLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpTickerNameLabel() {
        view.addSubview(tickerNameLabel)
        
        tickerNameLabel.text = stock.ticker
        tickerNameLabel.textColor = UIColor(named: "fifth")
        tickerNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        tickerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            tickerNameLabel.topAnchor.constraint(equalTo: paperParamLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpCurrencyPresentLabel() {
        view.addSubview(currencyPresentLabel)
        
        currencyPresentLabel.text = "Валюта тоговли:"
        currencyPresentLabel.textColor = UIColor(named: "sixth")
        currencyPresentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        currencyPresentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyPresentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            currencyPresentLabel.topAnchor.constraint(equalTo: tickerNameLabel.bottomAnchor, constant: 5)
        ])
    }

    private func setUpCurrencyNameLabel() {
        view.addSubview(currencyNameLabel)
        
        currencyNameLabel.text = "RUB"
        currencyNameLabel.textColor = UIColor(named: "fifth")
        currencyNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            currencyNameLabel.topAnchor.constraint(equalTo: tickerNameLabel.bottomAnchor, constant: 5)
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

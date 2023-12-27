import UIKit

final class MainTableCell: UITableViewCell {
    
    private lazy var logoImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var tickerLabel = UILabel()
    private lazy var currentPriceLabel = UILabel()
    private lazy var differencePriceLabel = UILabel()
    private lazy var containerView = UIView()
    
    static let cellIdentifier = "mainCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with stock: Stock) {
        var priceAccuracy = 2
        var percentsAccuracy = 2
        let differencePrice = round((stock.currentPrice - stock.openPrice) * 100) / 100
        let differencePercents = round((differencePrice / stock.openPrice) * 100 * 100) / 100
        
        logoImageView.image = stock.image
        nameLabel.text = stock.name
        tickerLabel.text = stock.ticker
        currentPriceLabel.text = "\(stock.currentPrice) ₽".replacingOccurrences(of: ".", with: ",")
        
        if Int(differencePrice * 100) % 10 == 0 {
            priceAccuracy = 1
        }
        
        if Int(differencePercents * 100) % 100 == 0 {
            percentsAccuracy = 0
        } else if Int(differencePercents * 100) % 10 == 0 {
            percentsAccuracy = 1
        }
        
        differencePriceLabel.text = String(format: "%+.*f ₽   %.*f%%", priceAccuracy, differencePrice, percentsAccuracy, abs(differencePercents)).replacingOccurrences(of: ".", with: ",")
        
        
        if differencePrice == 0 {
            differencePriceLabel.textColor = UIColor(named: "sixth")
        } else if differencePrice > 0 {
            differencePriceLabel.textColor = UIColor(named: "green")
        } else {
            differencePriceLabel.textColor = UIColor(named: "red")
        }
        
        if stock.isFavorite {
            containerView.layer.borderColor = UIColor(named: "mainAccentColor")?.cgColor
        } else {
            containerView.layer.borderColor = UIColor(named: "seventh")?.cgColor
        }
    }
    
    private func setContainer() {
        contentView.addSubview(containerView)
        
        contentView.backgroundColor = UIColor(named: "first")
        
        containerView.backgroundColor = UIColor(named: "second")
        containerView.layer.cornerRadius = mainConstant.cellCornerRadius
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = mainConstant.cellBorder
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: mainConstant.cellTopAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mainConstant.cellLeadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: mainConstant.cellTrailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: mainConstant.cellBottomAnchor)
        ])
        
        setLogoImage()
        setNameLabel()
        setTickerLabel()
        setCurrentPriceLabel()
        setDifferencePriceLabel()
    }
    
    private func setLogoImage() {
        containerView.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: mainConstant.logoImageLeadingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setNameLabel() {
        containerView.addSubview(nameLabel)
        
        nameLabel.font = UIFont.systemFont(ofSize: mainConstant.nameLabelFontSize, weight: .semibold)
        nameLabel.textColor = UIColor(named: "eighth")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: mainConstant.nameLabelLeadingAnchor)
        ])
    }
    
    private func setTickerLabel() {
        containerView.addSubview(tickerLabel)
        
        tickerLabel.font = UIFont.systemFont(ofSize: mainConstant.tickerLabelFontSize, weight: .medium)
        tickerLabel.textColor = UIColor(named: "sixth")
        
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: mainConstant.tickerLabelLeadingAnchor),
            tickerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
        ])
    }
    
    private func setCurrentPriceLabel() {
        containerView.addSubview(currentPriceLabel)
        
        currentPriceLabel.font = UIFont.systemFont(ofSize: mainConstant.priceLabelFontSize, weight: .semibold)
        currentPriceLabel.textColor = UIColor(named: "eighth")
        
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentPriceLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            currentPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: mainConstant.priceLabelTrailingAnchor)
        ])
    }
    
    private func setDifferencePriceLabel() {
        containerView.addSubview(differencePriceLabel)
        
        differencePriceLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        
        differencePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            differencePriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor),
            differencePriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -19)
        ])
    }
}

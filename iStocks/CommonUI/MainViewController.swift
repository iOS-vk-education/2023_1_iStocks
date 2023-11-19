import UIKit

class MainViewController: UIViewController {
        
    private lazy var searchBar = UISearchBar()
    private lazy var segmentedControl = UISegmentedControl(items: segmentedItems)
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    private let segmentedItems = ["ВСЕ", "Подписки"]
    
    private var printedStocks = stocks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewController")

        setNavigationItem()
        setSearchBar()
        setSegmentedControl()
        setTableView()
    }
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem()
        
        barButtonItem.title = "Главная"
        barButtonItem.tintColor = UIColor(named: "backButton")
        
        navigationItem.backBarButtonItem = barButtonItem
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "Название или тикер"
        searchBar.barTintColor = UIColor(named: "mainSearchBar")
        
        navigationItem.titleView = searchBar
    }
    
    private func setSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(suitDidChange), for: .valueChanged)
        segmentedControl.backgroundColor = UIColor(named: "mainSegmentedControl")
        segmentedControl.selectedSegmentTintColor = UIColor(named: "mainSegmentedControlSelected")
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "mainSegmentedControlText")!
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "mainSegmentedControlSelectedText")!
        ], for: .selected)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: mainConstant.segmentedControlLeadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: mainConstant.segmentedControlTrailingAnchor)
        ])
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = mainConstant.cellHeight
        tableView.backgroundColor = UIColor(named: "viewController")
        tableView.separatorStyle = .none

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: mainConstant.tableTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func suitDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            printedStocks = stocks
        case 1:
            printedStocks = stocks.filter({ x in x.isFavorite })
        default:
            fatalError()
        }
        
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        printedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.cellIdentifier, for: indexPath)
        guard let cell = cell as? MainTableCell else {
            fatalError()
        }

        cell.configure(with: printedStocks[indexPath.row])
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(StockViewController(), animated: true)
    }
}

final class MainTableCell: UITableViewCell {
    
    private lazy var logoImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var tickerLabel = UILabel()
    private lazy var priceLabel = UILabel()
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
        logoImageView.image = stock.image
        nameLabel.text = stock.name
        tickerLabel.text = stock.ticker
        priceLabel.text = "\(stock.price) ₽"
        
        if stock.isFavorite {
            containerView.layer.borderColor = UIColor(named: "mainCellBorderFavorite")?.cgColor
        } else {
            containerView.layer.borderColor = UIColor(named: "mainCellBorder")?.cgColor
        }
    }
    
    private func setContainer() {
        contentView.addSubview(containerView)
        
        contentView.backgroundColor = UIColor(named: "viewController")
        
        containerView.backgroundColor = UIColor(named: "mainCell")
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
        setPriceLabel()
    }
    
    private func setLogoImage() {
        containerView.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: mainConstant.logoImageLeadingAnchor)
        ])
    }
    
    private func setNameLabel() {
        containerView.addSubview(nameLabel)
        
        nameLabel.font = UIFont.systemFont(ofSize: mainConstant.nameLabelFontSize, weight: .semibold)
        nameLabel.textColor = UIColor(named: "mainNameLabel")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: mainConstant.nameLabelTopAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: mainConstant.nameLabelLeadingAnchor)
        ])
    }
    
    private func setTickerLabel() {
        containerView.addSubview(tickerLabel)
        
        tickerLabel.font = UIFont.systemFont(ofSize: mainConstant.tickerLabelFontSize, weight: .medium)
        tickerLabel.textColor = UIColor(named: "mainTickerLabel")
        
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: mainConstant.tickerLabelTopAnchor),
            tickerLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: mainConstant.tickerLabelLeadingAnchor)
        ])
    }
    
    private func setPriceLabel() {
        containerView.addSubview(priceLabel)
        
        priceLabel.font = UIFont.systemFont(ofSize: mainConstant.priceLabelFontSize, weight: .semibold)
        priceLabel.textColor = UIColor(named: "mainPriceLabel")
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: mainConstant.priceLabelTopAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: mainConstant.priceLabelTrailingAnchor)
        ])
    }
}

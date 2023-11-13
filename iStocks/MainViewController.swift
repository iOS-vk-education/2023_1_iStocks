import UIKit

// ТЕСТ
let stocks: [Stock] = [
    Stock(name: "Yandex", ticker: "YNDX", price: 2614.8, favorites: true),
    Stock(name: "ВК", ticker: "VKCO", price: 617.6, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: true),
    Stock(name: "Сбер Банк", ticker: "SBER", price: 278.15, favorites: false),
    Stock(name: "ВК", ticker: "VKCO", price: 617.6, favorites: false)
]

class MainViewController: UIViewController {
    
    private let cellIdentifier = "StockCell"
        
    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var filteredStocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewControllerColor

        setSearch()

        view.addSubview(tableView)
        setTable()
    }
    
    private func setSearch() {
        searchBar.placeholder = "Название или тикер"
        searchBar.barTintColor = .searchControllerColor
    }
    
    private func setTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = 69
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .viewControllerColor
        tableView.tableHeaderView = searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let stock = stocks[indexPath.section]

        cell.textLabel?.text = stock.name
        cell.textLabel?.textColor = .cellStockNameColor
        cell.backgroundColor = .cellStockColor
        cell.layer.cornerRadius = 26
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 3.25
    
        
        if stock.favorites {
            cell.layer.borderColor = UIColor.cellFavoriteStockBorderColor.cgColor
        } else {
            cell.layer.borderColor = UIColor.cellDefaultStockBorderColor.cgColor
        }

        return cell
    }
}

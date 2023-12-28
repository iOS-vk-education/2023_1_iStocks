import UIKit

class MainViewController: UIViewController {
    
    enum Screen: Int {
        case all
        case favorites
    }
    
    private var printedStocks: [Stock] = []
    
    private lazy var searchBar = UISearchBar()
    private lazy var segmentedControl = UISegmentedControl(items: segmentedItems)
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    private let segmentedItems = ["ВСЕ", "Избранное"]
    
    private var selectedScreen = Screen.all
    
    private var searchedStocks = [Stock]()
    private var isSearched = false
    private var searchedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "first")
    
        stocks = []
        fetchData()
        printedStocks = stocks
        
        setNavigationItem()
        setSearchBar()
        setSegmentedControl()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem()
        
        barButtonItem.title = "Главная"
        barButtonItem.tintColor = UIColor(named: "sixth")
        
        navigationItem.backBarButtonItem = barButtonItem
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "Название или тикер"
        searchBar.delegate = self
        searchBar.tintColor = UIColor(named: "seventh")
        
        searchBar.searchTextField.textColor = UIColor(named: "eighth")
        
        navigationItem.titleView = searchBar
    }
    
    private func setSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(suitDidChange), for: .valueChanged)
        segmentedControl.backgroundColor = UIColor(named: "third")
        segmentedControl.selectedSegmentTintColor = UIColor(named: "sixth")
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "sixth")!
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "third")!
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
        tableView.backgroundColor = UIColor(named: "first")
        tableView.separatorStyle = .none

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func suitDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedScreen = .all
        case 1:
            selectedScreen = .favorites
        default:
            fatalError()
        }
        
        configurePrintedStocks()
        configureSearchedStocks()
        tableView.reloadData()
    }
    
    private func configurePrintedStocks() {
        printedStocks = selectedScreen == .all ? stocks : stocks.filter{ stock in stock.isFavorite }
    }
    
    private func configureSearchedStocks() {
        searchedStocks = printedStocks.filter({
            $0.name.lowercased().prefix(searchedText.lowercased().count) == searchedText.lowercased() || $0.ticker.lowercased().prefix(searchedText.lowercased().count) == searchedText.lowercased()
        })
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configurePrintedStocks()
        configureSearchedStocks()
        
        return isSearched ? searchedStocks.count : printedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.cellIdentifier, for: indexPath)
        guard let cell = cell as? MainTableCell else {
            fatalError()
        }
        
        configurePrintedStocks()
        configureSearchedStocks()
        
        if isSearched {
            cell.configure(with: searchedStocks[indexPath.row])
        } else {
            cell.configure(with: printedStocks[indexPath.row])
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockViewController: StockViewController
        
        configurePrintedStocks()
        configureSearchedStocks()
        
        if isSearched {
            stockViewController = StockViewController(stock: searchedStocks[indexPath.row])
        } else {
            stockViewController = StockViewController(stock: printedStocks[indexPath.row])
        }
        
        navigationController?.pushViewController(stockViewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        configurePrintedStocks()
        searchedText = searchText
        isSearched = searchText.count != 0
        configureSearchedStocks()
        
        tableView.reloadData()
    }
}

extension MainViewController {
    func fetchData() {
            APIManager.shared.getData { [weak self] in
                self?.tableView.reloadData()
            }
        }
}

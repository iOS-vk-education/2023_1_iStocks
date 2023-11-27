import UIKit

class MainViewController: UIViewController {
    
    enum Screen: Int {
        case all
        case favorites
    }
    
    private lazy var searchBar = UISearchBar()
    private lazy var segmentedControl = UISegmentedControl(items: segmentedItems)
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    private let segmentedItems = ["ВСЕ", "Подписки"]
    
    private var selectedScreen = Screen.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewController")

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
        
        barButtonItem.title = "Главная страница"
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
            selectedScreen = .all
        case 1:
            selectedScreen = .favorites
        default:
            fatalError()
        }
        
        tableView.reloadData()
    }
    
    private func printedStocks() -> [Stock] {
        return selectedScreen == .all ? stocks : stocks.filter{ stock in stock.isFavorite }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        printedStocks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.cellIdentifier, for: indexPath)
        guard let cell = cell as? MainTableCell else {
            fatalError()
        }

        cell.configure(with: printedStocks()[indexPath.row])
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockViewController = StockViewController()
        stockViewController.stock = printedStocks()[indexPath.row]
        navigationController?.pushViewController(stockViewController, animated: true)
    }
}

import UIKit

class NotesViewController: UIViewController {
    
    private var printedStocks: [Stock] = []
    private var searchedStocks = [Stock]()
    private var isSearched = false
    
    private lazy var searchBar = UISearchBar()
    private lazy var tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "first")
        
        stocks = []
        fetchData()
        
        printedStocks = stocks.filter({ x in x.haveNote })
        setNavigationItem()
        setSearchBar()
        setTableView()
    }
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem()
        
        barButtonItem.title = "Заметки"
        barButtonItem.tintColor = UIColor(named: "sixth")
        
        navigationItem.backBarButtonItem = barButtonItem
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "Название или тикер"
        searchBar.tintColor = UIColor(named: "seventh")
        searchBar.delegate = self
        
        searchBar.searchTextField.textColor = UIColor(named: "eighth")
        
        navigationItem.titleView = searchBar
    }
    
    func setTableView() {
        view.addSubview(tableView)
        
        tableView.register(NoteTableCell.self, forCellReuseIdentifier: NoteTableCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 81
        tableView.backgroundColor = UIColor(named: "first")
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearched ? searchedStocks.count : printedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableCell.cellIdentifier, for: indexPath)
        guard let cell = cell as? NoteTableCell else {
            fatalError()
        }

        if isSearched {
            cell.configure(with: searchedStocks[indexPath.row])
        } else {
            cell.configure(with: printedStocks[indexPath.row])
        }
        
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockViewController: StockViewController
        
        if isSearched {
            stockViewController = StockViewController(stock: searchedStocks[indexPath.row])
        } else {
            stockViewController = StockViewController(stock: printedStocks[indexPath.row])
        }
        navigationController?.pushViewController(stockViewController, animated: true)
    }
}

extension NotesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = searchText.count != 0
        searchedStocks = printedStocks.filter({
            $0.name.lowercased().prefix(searchText.lowercased().count) == searchText.lowercased() || $0.ticker.lowercased().prefix(searchText.lowercased().count) == searchText.lowercased()
        })
        
        tableView.reloadData()
    }
}

extension NotesViewController {
    func fetchData() {
            APIManager.shared.getData { [weak self] in
                self?.tableView.reloadData()
            }
        }
}

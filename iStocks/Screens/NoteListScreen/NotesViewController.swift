import UIKit

class SubscriptionsViewController: UIViewController {
    
    private var printedStocks = stocks.filter({ x in x.haveNote })
    
    private lazy var tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewController")
        
        setNavigationItem()
        setTableView()
    }
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem()
        
        barButtonItem.title = "Заметки"
        barButtonItem.tintColor = UIColor(named: "backButton")
        
        navigationItem.backBarButtonItem = barButtonItem
    }
    
    func setTableView() {
        view.addSubview(tableView)
        
        tableView.register(NoteTableCell.self, forCellReuseIdentifier: NoteTableCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 81
        tableView.backgroundColor = UIColor(named: "viewController")
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension SubscriptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        printedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableCell.cellIdentifier, for: indexPath)
        guard let cell = cell as? NoteTableCell else {
            fatalError()
        }

        cell.configure(with: printedStocks[indexPath.row])
        
        return cell
    }
}

extension SubscriptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stockViewController = StockViewController()
        stockViewController.stock = printedStocks[indexPath.row]
        navigationController?.pushViewController(stockViewController, animated: true)
    }
}

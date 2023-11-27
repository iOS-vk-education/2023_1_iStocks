import UIKit

class ThemeViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain)

    private var cellsName = [String]()

    private let cellIdentifier = "themeCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "first")
            
        configCellsName()
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        lazy var tableHeight = tableView.rowHeight * CGFloat(tableView.numberOfRows(inSection: 0))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.isScrollEnabled = false
        tableView.rowHeight = decorationConstant.cellHeight
        tableView.layer.cornerRadius = decorationConstant.cellCornerRadius
        tableView.clipsToBounds = true
        
        tableView.separatorColor = UIColor(named: "twelfth")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: decorationConstant.tableLeadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: decorationConstant.tableTrailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
    }
    
    private func configCellsName() {
        for theme in Theme.allCases {
            cellsName.append(theme.rawValue)
        }
    }
}

extension ThemeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()

        cell.backgroundColor = UIColor(named: "thirteenth")

        content.text = cellsName[indexPath.row]
        content.textProperties.color = UIColor(named: "eighth")!
        
        if user.theme.rawValue == content.text! {
            cell.accessoryType = .checkmark
        }

        cell.contentConfiguration = content

        return cell
    }
}

extension ThemeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.cellForRow(at: [0, cellsName.firstIndex(of: user.theme.rawValue)!])?.accessoryType = .none
        cell?.accessoryType = .checkmark
        user.theme = Theme(rawValue: cellsName[indexPath.row])!
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

import UIKit

class DecorationViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain)

    private let cellsName = ["Светлое", "Темное", "Системное"]

    private let cellIdentifier = "decorationCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewController")
            
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: decorationConstant.tableLeadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: decorationConstant.tableTrailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
    }
}

extension DecorationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()

        cell.backgroundColor = UIColor(named: "decorationCell")
        cell.selectionStyle = .none

        content.text = cellsName[indexPath.row]
        content.textProperties.color = UIColor(named: "decorationCellName")!
        
        if user.decoration == content.text! {
            cell.accessoryType = .checkmark
        }

        cell.contentConfiguration = content

        return cell
    }
}

extension DecorationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.cellForRow(at: [0, cellsName.firstIndex(of: user.decoration)!])?.accessoryType = .none
        cell?.accessoryType = .checkmark
        user.decoration = cellsName[indexPath.row]
    }
}

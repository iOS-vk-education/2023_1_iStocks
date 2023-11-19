import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var imageView = UIImageView()
    private lazy var label = UILabel()
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    private lazy var button = UIButton()
    
    private let cellsName = ["Оформление", "Язык"]
    private let viewControllers = [DecorationViewController(), LanguageViewController()]
    
    private let cellIdentifier = "settingsCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewController")
        
        setNavigationItem()
        setImageView()
        setLabel()
        setTableView()
        
        if !user.isLogged {
            setButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setNavigationItem() {
        let rightBarButtonItem: UIBarButtonItem
        let backBarButtonItem = UIBarButtonItem()
        
        backBarButtonItem.title = "Настройки"
        backBarButtonItem.tintColor = UIColor(named: "backButton")
        
        navigationItem.backBarButtonItem = backBarButtonItem
        
        if user.isLogged {
            rightBarButtonItem = UIBarButtonItem(title: "Изм.", style: .plain, target: self, action: #selector(clickEdit))
            rightBarButtonItem.tintColor = UIColor(named: "settingsRightButton")
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    private func setImageView() {
        view.addSubview(imageView)
        
        imageView.image = user.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setLabel() {
        view.addSubview(label)
        
        label.text = user.username
        label.textColor = UIColor(named: "nickname")
        label.font = UIFont.systemFont(ofSize: settingsConstant.labelFontSize, weight: .semibold)
        
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: settingsConstant.labelTopAnchor),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        lazy var tableHeight = tableView.rowHeight * CGFloat(tableView.numberOfRows(inSection: 0))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.isScrollEnabled = false
        tableView.rowHeight = settingsConstant.cellHeight
        tableView.layer.cornerRadius = settingsConstant.cellCornerRadius
        tableView.clipsToBounds = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: settingsConstant.tableTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: settingsConstant.tableLeadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: settingsConstant.tableTrailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
    }
    
    private func setButton() {
        view.addSubview(button)
        
        button.setTitle("Войти в аккаунт", for: .normal)
        button.setTitleColor(UIColor(named: "settingsButtonTitle")!, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: settingsConstant.buttonFontSize, weight: .semibold)
        
        button.backgroundColor = UIColor(named: "settingsButton")
        button.layer.cornerRadius = settingsConstant.buttonCornerRaduis
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(clickRegister), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: settingsConstant.buttonTopAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: settingsConstant.tableLeadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: settingsConstant.tableTrailingAnchor),
            button.heightAnchor.constraint(equalToConstant: settingsConstant.buttonHeight)
        ])
    }
    
    @objc
    private func clickRegister() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc
    private func clickEdit() {
        navigationController?.pushViewController(EditViewController(), animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailLabel = UILabel()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        cell.backgroundColor = UIColor(named: "settingsCell")
        cell.selectionStyle = .none
        
        content.text = cellsName[indexPath.row]
        content.textProperties.color = UIColor(named: "settingsCellName")!
        
        if indexPath.row == 0 {
            detailLabel.text = user.decoration
        } else if indexPath.row == 1 {
            detailLabel.text = user.language
        }
        detailLabel.textColor = UIColor(named: "settingsCellSelected")
        
        detailLabel.sizeToFit()
        
        cell.accessoryView = detailLabel
        cell.contentConfiguration = content
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(viewControllers[indexPath.row], animated: true)
    }
}

import UIKit

class SettingsViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let cellIdentifier = "TableCell"
    
    private let sections = ["Оформление", "Язык"]
    private let decors = ["Системное", "Светлое", "Темное"]
    private let languages = ["Русский", "Английский"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewControllerColor
        
        view.addSubview(imageView)
        setImage()
        view.addSubview(label)
        setLabel()
        view.addSubview(tableView)
        setTable()
    }
    
    private func setImage() {
        imageView.image = UIImage(named: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setLabel() {
        label.text = "@nickname"
        label.textColor = .nicknameColor
    
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .viewControllerColor
        tableView.separatorColor = .settingsSeparatorColor
        
        tableView.rowHeight = 44
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 17),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.row]
        cell.backgroundColor = .settingsSectionColor
        cell.textLabel?.textColor = .settingsTextSectionColor
        
        return cell
    }
}

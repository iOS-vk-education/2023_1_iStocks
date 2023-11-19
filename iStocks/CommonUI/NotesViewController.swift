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
        
        tableView.rowHeight = notesConstant.cellHeight
        tableView.backgroundColor = UIColor(named: "viewController")
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: settingsConstant.tableTopAnchor),
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
        navigationController?.pushViewController(StockViewController(), animated: true)
    }
}

final class NoteTableCell: UITableViewCell {
    
    private lazy var logoImageView = UIImageView()
    private lazy var tickerLabel = UILabel()
    private lazy var noteLabel = UILabel()
    private lazy var containerView = UIView()
    
    static let cellIdentifier = "notesCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with stock: Stock) {
        logoImageView.image = stock.image
        tickerLabel.text = stock.ticker
        noteLabel.text = stock.note
    }
    
    private func setContainer() {
        contentView.addSubview(containerView)
        
        contentView.backgroundColor = UIColor(named: "viewController")
        
        containerView.backgroundColor = UIColor(named: "notesCell")
        containerView.layer.cornerRadius = notesConstant.cellCornerRadius
        containerView.layer.masksToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: notesConstant.cellTopAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: notesConstant.cellLeadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: notesConstant.cellTrailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: notesConstant.cellBottomAnchor)
        ])
        
        setLogoImage()
        setTickerLabel()
        setNoteLabel()
    }
    
    private func setLogoImage() {
        containerView.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: notesConstant.logoImageTopAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: notesConstant.logoImageLeadingAnchor)
        ])
    }
    
    private func setTickerLabel() {
        containerView.addSubview(tickerLabel)
        
        tickerLabel.font = UIFont.systemFont(ofSize: notesConstant.tickerLabelFontSize, weight: .medium)
        tickerLabel.textColor = UIColor(named: "notesTickerLabel")
        
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: notesConstant.tickerLabelTopAnchor),
            tickerLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
        ])
    }
    
    private func setNoteLabel() {
        containerView.addSubview(noteLabel)
        
        noteLabel.font = UIFont.systemFont(ofSize: notesConstant.noteLabelFontSize, weight: .medium)
        noteLabel.textColor = UIColor(named: "notesNoteLabel")
        
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: notesConstant.noteLabelTrailingAnchor)
        ])
    }
}

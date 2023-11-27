import UIKit

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
        containerView.layer.cornerRadius = 26
        containerView.layer.masksToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        setNoteLabel()
        setLogoImage()
        setTickerLabel()
    }
    
    private func setNoteLabel() {
        containerView.addSubview(noteLabel)
        
        noteLabel.font = UIFont.systemFont(ofSize: notesConstant.noteLabelFontSize, weight: .medium)
        noteLabel.textColor = UIColor(named: "notesNoteLabel")
        
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            noteLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setLogoImage() {
        containerView.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            logoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setTickerLabel() {
        containerView.addSubview(tickerLabel)
        
        tickerLabel.font = UIFont.systemFont(ofSize: notesConstant.tickerLabelFontSize, weight: .medium)
        tickerLabel.textColor = UIColor(named: "notesTickerLabel")
        
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tickerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            tickerLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
        ])
    }
}


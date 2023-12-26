import UIKit

class LoginViewController: UIViewController {
    private lazy var nameLabel = UILabel()
    private lazy var buttonLogIn = UIButton()
    private lazy var logScrollView = UIScrollView()
    private lazy var buttonSignUp = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "first")
        setUpNameLabel()
        setUplogScrollView()
        setUpButtonLogIn()
        setUpButtonSignUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = "StockSense"
        nameLabel.font = UIFont.systemFont(ofSize: 66, weight: .medium)
        nameLabel.textColor = UIColor(named: "sixth")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 227)
        ])
    }
    
    private func setUplogScrollView() {
        view.addSubview(logScrollView)
        
        var separatorView: UIView?
        
        let mailTextField = UITextField()
        let passwordTextField = UITextField()
        let textFields = [mailTextField, passwordTextField]
        
        let placeholders = ["Почта", "Пароль"]
        
        logScrollView.layer.cornerRadius = 10
        logScrollView.layer.masksToBounds = true
        logScrollView.backgroundColor = UIColor(named: "second")
        
        logScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = CGFloat(Double(44 * placeholders.count) + 0.25 * Double(placeholders.count - 1))
        NSLayoutConstraint.activate([
            logScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logScrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -16),
            logScrollView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        for (i, textField) in textFields.enumerated() {
            if i != 0 {
                separatorView = UIView()
                separatorView!.backgroundColor = UIColor(named: "twelfth")
                
                logScrollView.addSubview(separatorView!)
                separatorView!.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    separatorView!.heightAnchor.constraint(equalToConstant: 0.25),
                    separatorView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16 + 16),
                    separatorView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                    separatorView!.topAnchor.constraint(equalTo: textFields[i - 1].bottomAnchor)
                ])
            }
            
            textField.placeholder = placeholders[i]
            
            textField.textColor = UIColor(named: "eighth")
            textField.backgroundColor = UIColor(named: "second")
            
            textField.tintColor = UIColor(named: "seventh")
            
            textField.isSecureTextEntry = textField.placeholder == "Пароль"
            
            logScrollView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 44),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                textField.topAnchor.constraint(equalTo: (i == 0) ? logScrollView.topAnchor : separatorView!.bottomAnchor)
            ])
            
            textField.leftView = UIView(frame: CGRect(
                x: .zero,
                y: .zero,
                width: 16,
                height: textField.frame.height))
            textField.leftViewMode = .always
            
            textField.rightView = UIView(frame: CGRect(
                x: .zero,
                y: .zero,
                width: 16,
                height: textField.frame.height))
            textField.rightViewMode = .always
        }
    }
    
    private func setUpButtonLogIn() {
        view.addSubview(buttonLogIn)
        
        buttonLogIn.setTitle("Войти", for: .normal)
        buttonLogIn.setTitleColor(UIColor(named: "third"), for: .normal)
        buttonLogIn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        buttonLogIn.backgroundColor = UIColor(named: "sixth")
        
        buttonLogIn.layer.cornerRadius = 12
        buttonLogIn.clipsToBounds = true
        
        buttonLogIn.addTarget(self, action: #selector(clickLogIn), for: .touchUpInside)
        buttonLogIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonLogIn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLogIn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonLogIn.heightAnchor.constraint(equalToConstant: 44),
            buttonLogIn.topAnchor.constraint(equalTo: logScrollView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setUpButtonSignUp() {
        view.addSubview(buttonSignUp)
        
        buttonSignUp.setTitle("Регистрация", for: .normal)
        buttonSignUp.setTitleColor(UIColor(named: "sixth"), for: .normal)
        buttonSignUp.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        buttonSignUp.layer.borderWidth = 3.25
        buttonSignUp.layer.cornerRadius = 12
        
        buttonSignUp.layer.borderColor = UIColor(named: "sixth")?.cgColor
        buttonSignUp.clipsToBounds = true
        
        buttonSignUp.addTarget(self, action: #selector(clickSignUp), for: .touchUpInside)
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 44),
            buttonSignUp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45)
        ])
    }
    
    @objc
    private func clickLogIn() {
        user.isLogged = true
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func clickSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}

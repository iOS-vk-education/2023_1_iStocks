import UIKit

class LoginViewController: UIViewController {
    private lazy var nameLabel = UILabel()
    private lazy var loginButton = UIButton()
    private lazy var containerView = UIView()
    private lazy var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = UIColor(named: "first")
        setUpNameLabel()
        setUpView()
        setNavigationItem()
        setUploginButton()
        setUpsignUpButton()
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
    
    private func setUpView() {
        view.addSubview(containerView)
        
        var separatorView: UIView?
        
        let mailTextField = UITextField()
        let passwordTextField = UITextField()
        let textFields = [mailTextField, passwordTextField]
        
        let placeholders = ["Почта", "Пароль"]
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(named: "second")
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = CGFloat(Double(44 * placeholders.count) + 0.25 * Double(placeholders.count - 1))
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        for (i, textField) in textFields.enumerated() {
            if i != 0 {
                separatorView = UIView()
                separatorView!.backgroundColor = UIColor(named: "twelfth")
                
                containerView.addSubview(separatorView!)
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
            
            containerView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 44),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                textField.topAnchor.constraint(equalTo: (i == 0) ? containerView.topAnchor : separatorView!.bottomAnchor)
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
    
    private func setUploginButton() {
        view.addSubview(loginButton)
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(UIColor(named: "third"), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        loginButton.backgroundColor = UIColor(named: "sixth")
        
        loginButton.layer.cornerRadius = 12
        loginButton.clipsToBounds = true
        
        loginButton.addTarget(self, action: #selector(clickLogIn), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setUpsignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.setTitleColor(UIColor(named: "sixth"), for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        signUpButton.layer.borderWidth = 3.25
        signUpButton.layer.cornerRadius = 12
        
        signUpButton.layer.borderColor = UIColor(named: "sixth")?.cgColor
        signUpButton.clipsToBounds = true
        
        signUpButton.addTarget(self, action: #selector(clickSignUp), for: .touchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45)
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
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem()
        
        barButtonItem.title = "Войти"
        barButtonItem.tintColor = UIColor(named: "sixth")
        
        navigationItem.backBarButtonItem = barButtonItem
    }
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        containerView.endEditing(true)
    }
}

import UIKit

class SignUpViewController: UIViewController {
    private lazy var nameLabel = UILabel()
    private lazy var buttonLogIn = UIButton()
    private lazy var containerView = UIView()
    private lazy var passwordScrollView = UIScrollView()
    private lazy var buttonSignUp = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = UIColor(named: "first")
        setUpNameLabel()
        setUpInfScrollView()
        setUpPasswordScrollView()
        setUpButtonLogIn()
    }
    
    private func setUpNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = "StockSense"
        nameLabel.font = UIFont.systemFont(ofSize: 66, weight: .medium)
        nameLabel.textColor = UIColor(named: "sixth")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 170)
        ])
    }
    
    private func setUpInfScrollView() {
        view.addSubview(containerView)
        
        var separatorView: UIView?
        
        let mailTextField = UITextField()
        let passwordTextField = UITextField()
        let textFields = [mailTextField, passwordTextField]
        
        let placeholders = ["Почта", "Никнейм"]
        
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
    
    private func setUpPasswordScrollView() {
        view.addSubview(passwordScrollView)
        
        var separatorView: UIView?
        
        let mailTextField = UITextField()
        let passwordTextField = UITextField()
        let textFields = [mailTextField, passwordTextField]
        
        let placeholders = ["Пароль", "Повторный пароль"]
        
        passwordScrollView.layer.cornerRadius = 10
        passwordScrollView.layer.masksToBounds = true
        passwordScrollView.backgroundColor = UIColor(named: "second")
        
        passwordScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = CGFloat(Double(44 * placeholders.count) + 0.25 * Double(placeholders.count - 1))
        NSLayoutConstraint.activate([
            passwordScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordScrollView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            passwordScrollView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        for (i, textField) in textFields.enumerated() {
            if i != 0 {
                separatorView = UIView()
                separatorView!.backgroundColor = UIColor(named: "twelfth")
                
                passwordScrollView.addSubview(separatorView!)
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
            textField.isSecureTextEntry = true
            
            passwordScrollView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 44),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                textField.topAnchor.constraint(equalTo: (i == 0) ? passwordScrollView.bottomAnchor :  separatorView!.bottomAnchor)
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
            buttonLogIn.topAnchor.constraint(equalTo: passwordScrollView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc
    private func clickLogIn() {
        user.isLogged = true
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        containerView.endEditing(true)
        passwordScrollView.endEditing(true)
    }
}

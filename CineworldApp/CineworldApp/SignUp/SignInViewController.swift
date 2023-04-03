//
//  SignInViewController.swift
//  CineworldApp
//
//  Created by ульяна on 18.02.23.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signUpLabel = UILabel()
    var buttonAccount: UIButton!
    var signInButton: UIButton!
    var backgroundImage = UIImageView()
    var emailErrorLabel = UILabel()
    var passwordErrorLabel = UILabel()
    var activityIndicator: UIActivityIndicatorView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpStackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cornerRadiusTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func cornerRadiusTextFields() {
        emailTextField.layer.cornerRadius = emailTextField.frame.height/2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        signInButton.layer.cornerRadius = signInButton.frame.height/2
        
    }
    
    private func setUpUI() {
        
        let background = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.center = self.view.center
        backgroundImage.image = background
        view.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        signUpLabel.text = "sign in\nto see cineworld"
        signUpLabel.numberOfLines = 0
        signUpLabel.textColor = .white
        signUpLabel.textAlignment = .left
        signUpLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        signUpLabel.text = signUpLabel.text?.uppercased()
        self.view.addSubview(signUpLabel)
        
        let placeholderForEmail = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.00)])
        emailTextField.attributedPlaceholder = placeholderForEmail
        emailTextField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        emailTextField.textColor = .white
        emailTextField.delegate = self
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.backgroundColor = .clear
        emailTextField.keyboardType = UIKeyboardType.default
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.view.addSubview(emailTextField)
        
        self.emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        emailErrorLabel.text = "sign up to see cineworld"
        emailErrorLabel.numberOfLines = 0
        emailErrorLabel.textColor = UIColor(red: 0.69, green: 0.42, blue: 0.22, alpha: 1.00)
        emailErrorLabel.textAlignment = .left
        emailErrorLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailErrorLabel.isHidden = true
        self.view.addSubview(emailErrorLabel)
        
        let placeholderForPassword = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.00)])
        passwordTextField.attributedPlaceholder = placeholderForPassword
        passwordTextField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        passwordTextField.textColor = .white
        passwordTextField.delegate = self
        
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.backgroundColor = .clear
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.view.addSubview(passwordTextField)
        
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        passwordErrorLabel.text = "Please enter correct password"
        passwordErrorLabel.numberOfLines = 0
        passwordErrorLabel.textColor = UIColor(red: 0.69, green: 0.42, blue: 0.22, alpha: 1.00)
        passwordErrorLabel.textAlignment = .left
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordErrorLabel.isHidden = true
        self.view.addSubview(passwordErrorLabel)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = self.backgroundImage.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator!)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        let signIn = UIButton(type: .system)
        signIn.setTitle("Sign in", for: .normal)
        signIn.addTarget(self, action: #selector(signInAction(_:)), for: .touchUpInside)
        signIn.setTitleColor(UIColor.black, for: .normal)
        signIn.backgroundColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        signIn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.signInButton = signIn
        self.view.addSubview(signIn)
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signIn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonDontHaveAnAccount = UIButton(type: .system)
        buttonDontHaveAnAccount.addTarget(self, action: #selector(donotHaveAnAccountAction(_:)), for: .touchUpInside)
        buttonDontHaveAnAccount.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let attributedString = NSAttributedString(string: NSLocalizedString("Don't have an account yet?", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        buttonDontHaveAnAccount.setAttributedTitle(attributedString, for: .normal)
        
        self.buttonAccount = buttonDontHaveAnAccount
        self.view.addSubview(buttonAccount)
        self.buttonAccount.translatesAutoresizingMaskIntoConstraints = false
        
        buttonAccount.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setUpStackView() {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 16.0
        
        stackView.addArrangedSubview(signUpLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(emailErrorLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordErrorLabel)
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(buttonAccount)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    }
    
    @objc func signInAction(_ sender:UIButton!) {
        createUser()
    }
    
    private func displayWarningLabel(withTextForEmail textEmail: String?, withTextForPassword textPassword: String?) {
        if let text = textEmail {
            emailErrorLabel.text = text
            emailErrorLabel.isHidden = false
        } else {
            emailErrorLabel.isHidden = true
        }
        
        if let text = textPassword {
            passwordErrorLabel.text = text
            passwordErrorLabel.isHidden = false
        } else {
            passwordErrorLabel.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if emailTextField.hasText && passwordTextField.hasText {
            createUser()
        }
        return true
    }
    
    func createUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "",
              password != "" else {
            displayWarningLabel(withTextForEmail: "Invalid email",
                                withTextForPassword: "Incorrect password")
            return
        }
        activityIndicator?.isHidden = false
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            self?.activityIndicator?.isHidden = true

            if let error = error {
                
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {

                    switch errCode {
                    case .invalidEmail:
                        self?.displayWarningLabel(withTextForEmail: "Invalid email \(error.localizedDescription)",
                                                  withTextForPassword: nil)
                    case .emailAlreadyInUse:
                        self?.displayWarningLabel(withTextForEmail: "Invalid email \(error.localizedDescription)",
                                                  withTextForPassword: nil)
                    case .wrongPassword:
                        self?.displayWarningLabel(withTextForEmail: nil,
                                                  withTextForPassword: "Incorrect password")
                    default:
                        print("Create User Error: \(error)")
                    }
                }
                
            } else {
                guard let user = user else {
                    return
                }
                
                let userRef = self?.ref.child(user.user.uid)
                userRef?.setValue(["email": user.user.email])
            
                let vc = TabBar()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    @objc func donotHaveAnAccountAction(_ sender:UIButton!) {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




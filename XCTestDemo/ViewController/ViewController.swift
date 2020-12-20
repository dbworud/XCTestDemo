//
//  ViewController.swift
//  XCTestDemo
//
//  Created by jaekyung you on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyData = [User(username: "youjk96", password: "dbworud0519")]
    
    private let validation : ValidationService
    
    // Need initializer to bind ValidationService
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginOn(_ sender: Any) {
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        do {
            /* Refactoring
            guard let username = usernameTextField.text, let password = passwordTextField.text else {
                throw ValidationError.invalidValue
            }
            
            guard username.count > 3 else { throw ValidationError.usernameTooShort }
            guard username.count < 3 else { throw ValidationError.usernameTooLong }
            guard password.count >= 8 else { throw ValidationError.passwordTooShort }
            guard password.count > 20 else { throw ValidationError.passwordTooLong }
        */
        
            let username = try validation.validateUsername(usernameTextField.text)
            let password = try validation.validatePassworld(passwordTextField.text)
        
            // Login to Database
            if let user = dummyData.first(where: { user in
                user.username == username && user.password == password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
//                let alert = UIAlertController(title: "알림", message: "You successfully logged in as \(user.username)", preferredStyle: .alert)
//                let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
//                    print("pressed ok")
//                }
//
//                alert.addAction(okButton)
//                present(alert, animated: true)
            } else {
                throw LoginError.invalidCredentials
            }
            
        }
        catch{
            present(error as! ValidationError)
        }
    }
    
    
    func presentAlert(with message: String) {
        
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            print("pressed ok")
        }
        
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func present(_ error: ValidationError) {
        let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "dismiss", style: .destructive) { (action) in
            print("pressed dismiss")
        }
        
        alert.addAction(dismiss)
        present(alert, animated: true)
    }

}



//
//  ViewController.swift
//  iOS-HW23BruteForse-Olga Mikhailova
//
//  Created by FoxxFire on 23.11.2025.
//

import UIKit

class BruteForseViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var isStartBrute = false
    private var isStopBrute = false
    private var safePassword = ""
    private var targetPassword = ""
    
    // MARK: - Computed Properties
    
    private var bruteForseView: BruteForseView {
        guard let customView = view as? BruteForseView else {
            fatalError("View didn't create")
        }
        return customView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = BruteForseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        bruteForseView.textField.delegate = self
        
        // Keyboard - Dismiss keyboard on tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // MARK: - Button Actions Setup
        bruteForseView.startButton.addAction(UIAction { _ in
            guard let password = self.bruteForseView.textField.text,
                  !password.isEmpty else {
                self.bruteForseView.label.text = "Put your password"
                return
            }
            self.startBruteForce(passwordToUnlock: password)
        }, for: .touchUpInside)
        
        bruteForseView.stopButton.addAction(UIAction {_ in
            self.stopBruteForce()
        }, for: .touchUpInside)
        
        bruteForseView.togglePasswordButton.addAction(UIAction { [weak self] _ in
            self?.togglePasswordVisibility()
        }, for: .touchUpInside)
        
        // Keyboard - Text field change handler
        bruteForseView.textField.addAction(UIAction { [weak self] _ in
            self?.textFieldDidChange()
        }, for: .editingChanged)
    }
    
    // MARK: - Brute Force Methods
    
    func startBruteForce(passwordToUnlock: String) {
        isStartBrute = true
        isStopBrute = false
        
        if targetPassword != passwordToUnlock {
            safePassword = ""
            targetPassword = passwordToUnlock
        }
        
        
        bruteForseView.activityIndicator.startAnimating()
        bruteForseView.startButton.isEnabled = false
        bruteForseView.textField.isSecureTextEntry = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
            var password: String = self.safePassword
            
            while password != passwordToUnlock && !self.isStopBrute {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                self.safePassword = password
                print(password)
                
                DispatchQueue.main.async{
                    self.bruteForseView.label.text = password
                }
            }
            
            DispatchQueue.main.async {
                self.finishBruteForce(success: password == passwordToUnlock, password: password)
            }
        }
    }
    
    private func stopBruteForce() {
        isStopBrute = true
        isStartBrute = false
        
        bruteForseView.activityIndicator.stopAnimating()
        bruteForseView.startButton.isEnabled = true
        
        bruteForseView.label.text = "Press start to continue"
    }
    
    private func finishBruteForce(success: Bool, password: String) {
        isStartBrute = false
        
        bruteForseView.activityIndicator.stopAnimating()
        bruteForseView.startButton.isEnabled = true
        
        if success {
            bruteForseView.label.text = password
            bruteForseView.textField.isSecureTextEntry = false
            bruteForseView.togglePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            bruteForseView.label.text = "Stopped bruting"
        }
    }
    
    // MARK: - Keyboard & TextField Methods
    
    private func togglePasswordVisibility() {
        let isSecure = bruteForseView.textField.isSecureTextEntry
        bruteForseView.textField.isSecureTextEntry = !isSecure
        
        let imageName = isSecure ? "eye" : "eye.slash"
        bruteForseView.togglePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func textFieldDidChange() {
        // Когда пользователь меняет текст - сбрасываем прогресс
        if let newText = bruteForseView.textField.text, newText != targetPassword {
            safePassword = "" // сбрасываем прогресс
            targetPassword = newText // обновляем целевой пароль
            bruteForseView.label.text = "Ready to search"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Keyboard - Dismiss keyboard
        return true
    }
    
    // Keyboard - Dismiss keyboard on tap outside
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}




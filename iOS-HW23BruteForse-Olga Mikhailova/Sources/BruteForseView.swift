
//
//  BruteForseView.swift
//  Pr2503
//
//  Created by FoxxFire on 20.11.2025.
//

import UIKit

// MARK: - Main Brute Force View

final class BruteForseView: UIView {
    
    // MARK: - UI Elements
    
    let textField = UITextField()
    let label = UILabel()
    let startButton = UIButton()
    let stopButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()
    let togglePasswordButton = UIButton()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = UIColor.lightGray
        
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Keyboard - Text Field Configuration
        textField.placeholder = "Write password here"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.keyboardType = .asciiCapable // Keyboard - ASCII keyboard type
        textField.returnKeyType = .done  // Keyboard - Return key type
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Keyboard - Toggle password visibility button
        togglePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        togglePasswordButton.tintColor = .gray
        togglePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = UIColor.blue
        label.text = "HI"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Start brut", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        startButton.setTitleColor(.green, for: .normal)
        startButton.backgroundColor = .brown
        startButton.layer.cornerRadius = 6
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        stopButton.setTitle("Stop brut", for: .normal)
        stopButton.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        stopButton.setTitleColor(.yellow, for: .normal)
        stopButton.backgroundColor = .darkGray
        stopButton.layer.cornerRadius = 6
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        addSubview(textField)
        addSubview(togglePasswordButton)
        addSubview(label)
        addSubview(startButton)
        addSubview(stopButton)
    }
    
    // MARK: - Layout Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 140),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 200),
            
            togglePasswordButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            togglePasswordButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4),
            togglePasswordButton.widthAnchor.constraint(equalToConstant: 30),
            togglePasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            activityIndicator.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 300),
            
            startButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            
            stopButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            stopButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

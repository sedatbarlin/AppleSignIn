//
//  DetailsViewController.swift
//  AppleSignIn
//
//  Created by Sedat on 28.07.2024.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    private var userId: String = ""
    private var firstName: String = ""
    private var lastName: String = ""
    private var email: String = ""
    private let userIdLabel = UILabel()
    private let firstNameLabel = UILabel()
    private let lastNameLabel = UILabel()
    private let emailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func configure(userId: String, firstName: String, lastName: String, email: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        configureLabels()
    }

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(userIdLabel)
        view.addSubview(firstNameLabel)
        view.addSubview(lastNameLabel)
        view.addSubview(emailLabel)
        
        userIdLabel.numberOfLines = 0
        userIdLabel.textAlignment = .center
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        firstNameLabel.textColor = .white
        firstNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIdLabel.snp.bottom).offset(20)
        }
        
        lastNameLabel.textColor = .white
        lastNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameLabel.snp.bottom).offset(20)
        }
        
        emailLabel.textColor = .white
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lastNameLabel.snp.bottom).offset(20)
        }
    }
    
    private func configureLabels() {
        userIdLabel.text = "User ID: \(userId)"
        firstNameLabel.text = "First Name: \(firstName)"
        lastNameLabel.text = "Last Name: \(lastName)"
        emailLabel.text = "Email: \(email)"
    }
}

//
//  LoginViewController.swift
//  AppleSignIn
//
//  Created by Sedat on 28.07.2024.
//

import UIKit
import AuthenticationServices
import SnapKit

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    private var userId: String = ""
    private var firstName: String = ""
    private var lastName: String = ""
    private var email: String = ""
    private var appleLoginButton = ASAuthorizationAppleIDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        
        appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        appleLoginButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
        view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    @objc private func handleAppleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func navigateToDetails() {
        let detailsVC = DetailsViewController()
        detailsVC.configure(userId: userId, 
                            firstName: firstName,
                            lastName: lastName,
                            email: email)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization error: \(error.localizedDescription)")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            userId = credential.user
            firstName = credential.fullName?.givenName ?? ""
            lastName = credential.fullName?.familyName ?? ""
            email = credential.email ?? ""
            navigateToDetails()
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

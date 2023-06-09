//
//  SuccessViewController.swift
//  NennoPizza
//
//  Created by Slava Chirita on 09.06.2023.
//

import UIKit

protocol SuccessViewControllerInterface: AnyObject {
    
}

final class SuccessViewController: UIViewController, SuccessViewControllerInterface {
    private var router: SuccessRouterInterface?
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 34)
        label.textColor = UIColor(red: 223/255, green: 78/255, blue: 74/255, alpha: 1)
        label.text = "Thank you\nfor your order!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.setTitle("RETURN TO MAIN SCREEN", for: .normal)
        button.backgroundColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(router: SuccessRouterInterface) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        router = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)

        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func didTapBackButton() {
        router?.returnToHomeScreen()
    }
}

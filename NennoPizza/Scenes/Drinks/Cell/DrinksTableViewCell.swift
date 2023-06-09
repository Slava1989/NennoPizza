//
//  DrinksTableViewCell.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var innerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 17
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1), for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        mainStackView.addArrangedSubview(innerStackView)
        mainStackView.addArrangedSubview(priceLabel)
        
        innerStackView.addArrangedSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 15),
            deleteButton.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        innerStackView.addArrangedSubview(productName)
    }
    
    func setupCell(drink: DrinksScreen.FetchDrinks.Drinks) {
        priceLabel.text = "$\(drink.price)"
        productName.text = drink.name
    }
}


//
//  TotalCartTableViewCell.swift
//  NennoPizza
//
//  Created by Slava Chirita on 07.06.2023.
//

import UIKit

final class TotalCartTableViewCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
        ])
        
        mainStackView.addArrangedSubview(totalLabel)
        mainStackView.addArrangedSubview(priceLabel)
    }
    
    func setupCell(totalPrice: Double) {
        priceLabel.text = "$\(totalPrice)"
    }
}

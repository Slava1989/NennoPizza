//
//  IngridientTableViewCell.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import UIKit

class IngridientTableViewCell: UITableViewCell {
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var checkMarkAndNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
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
        contentView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        containerStackView.addArrangedSubview(checkMarkAndNameStackView)
        
        
        contentView.addSubview(checkMarkAndNameStackView)
        NSLayoutConstraint.activate([
            checkMarkAndNameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkMarkAndNameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkMarkAndNameStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        checkMarkAndNameStackView.addArrangedSubview(checkMarkImageView)
        checkMarkAndNameStackView.addArrangedSubview(nameLabel)
        checkMarkAndNameStackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func configureCell(viewModel: IngridientsModels.IngridientsViewModel) {
        checkMarkImageView.alpha = viewModel.isSelected ? 1 : 0
        nameLabel.text = viewModel.name
        priceLabel.text = "$ \(viewModel.price)"
    }
    
}

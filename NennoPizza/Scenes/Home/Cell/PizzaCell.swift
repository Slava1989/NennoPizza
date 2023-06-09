//
//  PizzaCell.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import UIKit
import SDWebImage

protocol PizzaCellDelegate: AnyObject {
    func didTapPriceView(for pizzaModel: Home.FetchPizza.PizzaViewModel)
}

final class PizzaCell: UITableViewCell {
    weak var delegate: PizzaCellDelegate?
    
    private var pizzaModel: Home.FetchPizza.PizzaViewModel?
    
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pizzaNameContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 0.8)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var pizzaNameAndIngridientsStackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ingridientsAndPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pizzaNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ingridientsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        label.numberOfLines = 0
        label.text = "Mozzarella, tomato"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 255/255, green: 205/255, blue: 43/255, alpha: 1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPriceContainer))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
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
    
    override func prepareForReuse() {
        pizzaNameLabel.text = ""
        priceLabel.text = ""
        ingridientsLabel.text = ""
    }
    
    @objc private func didTapPriceContainer() {
        guard let pizzaModel = pizzaModel else {
            return
        }
        
        delegate?.didTapPriceView(for: pizzaModel)
    }
    
    private func setupUI() {
        self.contentView.addSubview(backroundImageView)
        NSLayoutConstraint.activate([
            backroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        self.contentView.addSubview(pizzaImageView)
        NSLayoutConstraint.activate([
            pizzaImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            pizzaImageView.widthAnchor.constraint(equalToConstant: 500),
//            pizzaImageView.heightAnchor.constraint(equalToConstant: 500),
            pizzaImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pizzaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        self.contentView.addSubview(pizzaNameContainerView)
        NSLayoutConstraint.activate([
            pizzaNameContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pizzaNameContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pizzaNameContainerView.heightAnchor.constraint(equalToConstant: 69),
            pizzaNameContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        pizzaNameContainerView.addSubview(pizzaNameAndIngridientsStackViewContainer)
        NSLayoutConstraint.activate([
            pizzaNameAndIngridientsStackViewContainer.topAnchor.constraint(equalTo: pizzaNameContainerView.topAnchor, constant: 3),
            pizzaNameAndIngridientsStackViewContainer.leadingAnchor.constraint(equalTo: pizzaNameContainerView.leadingAnchor, constant: 6),
            pizzaNameAndIngridientsStackViewContainer.trailingAnchor.constraint(equalTo: pizzaNameContainerView.trailingAnchor, constant: -6)
        ])
        
        pizzaNameAndIngridientsStackViewContainer.addArrangedSubview(pizzaNameLabel)
        pizzaNameAndIngridientsStackViewContainer.addArrangedSubview(ingridientsAndPriceStackView)
        
        ingridientsAndPriceStackView.addArrangedSubview(ingridientsLabel)
        ingridientsAndPriceStackView.addArrangedSubview(priceContainerView)
        
        NSLayoutConstraint.activate([
            priceContainerView.widthAnchor.constraint(equalToConstant: 64),
            priceContainerView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        priceContainerView.addSubview(priceStackView)
        NSLayoutConstraint.activate([
            priceStackView.centerXAnchor.constraint(equalTo: priceContainerView.centerXAnchor),
            priceStackView.centerYAnchor.constraint(equalTo: priceContainerView.centerYAnchor)
        ])
        
        priceStackView.addArrangedSubview(cartImageView)
        priceStackView.addArrangedSubview(priceLabel)
        
    }
    
    func setupCell(viewModel: Home.FetchPizza.PizzaViewModel) {
        self.pizzaModel = viewModel
        pizzaNameLabel.text = viewModel.pizza.name
        priceLabel.text = "$ \(viewModel.finalPrice)"
        ingridientsLabel.text = viewModel.ingridients.map { $0.1 }.joined(separator: ", ")
        backroundImageView.image = UIImage(named: "bg_wood")
        if let imageURL = viewModel.imageURL, !imageURL.isEmpty, !imageURL.contains("error") {
            pizzaImageView.contentMode = .scaleAspectFit
            pizzaImageView.sd_setImage(with: URL(string: imageURL))
        } else {
            pizzaImageView.contentMode = .scaleAspectFill
            pizzaImageView.image = UIImage(systemName: "x.circle")
            pizzaImageView.tintColor = .gray
        }
    }
}

//
//  IngridientsViewController.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import UIKit
import SDWebImage

protocol IngridientsViewControllerInterface: AnyObject {
    func displayPizzaImageAndName(image: UIImage?, url: String?, name: String)
    func displayFetchedIngridients(viewModelList: [IngridientsModels.IngridientsViewModel])
    func updateCheckoutButton(price: Double)
}

final class IngridientsViewController: UIViewController, IngridientsViewControllerInterface {
    private var output: IngridientsInteractorInterface?
    private var router: IngridientRouterInterface
    private var viewModelList: [IngridientsModels.IngridientsViewModel] = []
    private var popupMessageViewHeightConstraint: NSLayoutConstraint!
    private var isAnimationPlaying: Bool = false
    
    private lazy var popupMessageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var popupMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.alpha = 0
        label.text = "ADDED TO CART"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "bg_wood")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ingridientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IngridientTableViewCell.self, forCellReuseIdentifier: "IngridientTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 205/255, blue: 43/255, alpha: 1)
        button.addTarget(self, action: #selector(checkoutButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: IngridientsInteractorInterface, router: IngridientRouterInterface) {
        self.output = output
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output?.getPizzaDetails()
        output?.updateCheckoutButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output = nil
    }
    
    private func setupUI() {
        view.addSubview(backroundImageView)
        NSLayoutConstraint.activate([
            backroundImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            backroundImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            backroundImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            backroundImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5)
        ])
        
        view.addSubview(pizzaImageView)
        NSLayoutConstraint.activate([
            pizzaImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pizzaImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pizzaImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            pizzaImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5)
        ])
        
        
        view.addSubview(popupMessageView)
        NSLayoutConstraint.activate([
            popupMessageView.topAnchor.constraint(equalTo: backroundImageView.topAnchor),
            popupMessageView.leadingAnchor.constraint(equalTo: backroundImageView.leadingAnchor),
            popupMessageView.trailingAnchor.constraint(equalTo: backroundImageView.trailingAnchor)
        ])
        
        popupMessageViewHeightConstraint = NSLayoutConstraint(
            item: popupMessageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 0.0,
            constant: 0)
        popupMessageViewHeightConstraint.isActive = true
        
        popupMessageView.addSubview(popupMessageLabel)
        NSLayoutConstraint.activate([
            popupMessageLabel.centerXAnchor.constraint(equalTo: popupMessageView.centerXAnchor),
            popupMessageLabel.centerYAnchor.constraint(equalTo: popupMessageView.centerYAnchor)
        ])
        
        
        view.addSubview(ingridientsLabel)
        NSLayoutConstraint.activate([
            ingridientsLabel.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor, constant: 12),
            ingridientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ingridientsLabel.bottomAnchor, constant: 6),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        view.addSubview(addToCartButton)
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addToCartButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func displayFetchedIngridients(viewModelList: [IngridientsModels.IngridientsViewModel]) {
        self.viewModelList = viewModelList
        tableView.reloadData()
    }
    
    func displayPizzaImageAndName(image: UIImage?, url: String?, name: String) {
        navigationItem.title = name.uppercased()

        if let url = url {
            pizzaImageView.sd_setImage(with: URL(string: url))
            return
        }
        
        pizzaImageView.image = image
    }
    
    func updateCheckoutButton(price: Double) {
        addToCartButton.setTitle("ADD TO CART ($\(price))", for: .normal)
    }
    
    @objc private func checkoutButtonDidTap() {
        output?.saveToCart()
        
        if !isAnimationPlaying {
            UIView.animate(withDuration: 0.2, animations: {
                self.isAnimationPlaying = true
                self.popupMessageLabel.alpha = 1
                self.popupMessageViewHeightConstraint.constant = 20
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 3, animations: {
                    self.popupMessageLabel.alpha = 0
                    self.popupMessageViewHeightConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.isAnimationPlaying = false
                }
            })
        }
    }
}

extension IngridientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModelList[indexPath.row]
        viewModel.selectIngridient()
        output?.updateCheckoutButton()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension IngridientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientTableViewCell", for: indexPath) as? IngridientTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(viewModel: viewModelList[indexPath.row])
        
        return cell
    }
}

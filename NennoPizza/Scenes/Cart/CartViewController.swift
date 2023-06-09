//
//  CartViewController.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import UIKit

protocol CartViewControllerInterface: AnyObject {
    func setTotalSum(totalSum: Double)
    func showEmptyCartMessage()
    func showSuccessScreen()
}

final class CartViewController: UIViewController, CartViewControllerInterface {
    private var output: CartInteractorInterface?
    private var router: CartRouterInterface?
    private var totalSum: Double = 0.0
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.tintColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        tableView.register(TotalCartTableViewCell.self, forCellReuseIdentifier: "TotalCartTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCheckout), for: .touchUpInside)
        button.setTitle("CHECKOUT", for: .normal)
        button.backgroundColor = UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: CartInteractorInterface, router: CartRouterInterface) {
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
        
        navigationItem.title = "CART".uppercased()
        
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy),
            NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        rightButton.setBackgroundImage(UIImage(named: "ic_drinks"), for: .normal)
        rightButton.addTarget(self, action: #selector(drinksButtonDidTap), for: .touchUpInside)
        
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output?.getTotalSum()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(checkoutButton)
        NSLayoutConstraint.activate([
            checkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(loaderView)
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func drinksButtonDidTap() {
        router?.showDrinksScreen()
    }
    
    @objc private func didTapCheckout() {
        loaderView.startAnimating()
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        view.isUserInteractionEnabled = false
        output?.checkout()
    }
    
    func setTotalSum(totalSum: Double) {
        self.totalSum = totalSum
        view.isUserInteractionEnabled = true
        tableView.reloadData()
    }
    
    func showEmptyCartMessage() {
        let alertController = UIAlertController(title: "Warning", message: "Your Cart is empty", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in self?.router?.returnToPizzaScreen()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessScreen() {
        loaderView.stopAnimating()
        router?.showSuccessScreen()
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= Cart.shared.retrieveGoods().count {
            return 70
        }
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.removeItemFromCart(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        output?.getTotalSum()
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.retrieveGoods().count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= Cart.shared.retrieveGoods().count {
            return setupTotalCartTableViewCell(indexPath: indexPath)
        }
        return setupCartTableViewCell(indexPath: indexPath)
    }
    
    private func setupTotalCartTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCartTableViewCell", for: indexPath) as? TotalCartTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(totalPrice: totalSum)
        return cell
    }
    
    private func setupCartTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let cartViewModel = Cart.shared.retrieveGoods()[indexPath.row]
        cell.setupCell(cartViewModel: cartViewModel)
        
        return cell
    }
}

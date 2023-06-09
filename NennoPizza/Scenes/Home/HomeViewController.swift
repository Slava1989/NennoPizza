//
//  HomeViewController.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func displayFetchedPizzas(viewModelList: [Home.FetchPizza.PizzaViewModel],
                              ingridients: [Home.FetchIngredients.Ingridient])
    func updateCartView(numberOfGoods: Int)
    func showErrorMessage(message: String)
}

final class HomeViewController: UIViewController, HomeViewControllerInterface {
    private var output: HomeInteractorInterface
    private var router: HomeRouterInterface
    
    private var pizzaList: [Home.FetchPizza.PizzaViewModel]?
    private var ingridientsList: [Home.FetchIngredients.Ingridient]?
    private var isAnimationPlaying: Bool = false
    private var cartLabel: UILabel!
    
    private var popupMessageViewHeightConstraint: NSLayoutConstraint!
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PizzaCell.self, forCellReuseIdentifier: "PizzaCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(output: HomeInteractorInterface, router: HomeRouterInterface) {
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
        setupNavigationBar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.checkCart()
        output.getPizzas()
    }
    
    @objc private func cartButtonDidTap() {
        if Cart.shared.retrieveGoods().count == 0 {
            let alert = UIAlertController(title: "Oops", message: "Your cart is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        router.showCartScreen()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Nenno's pizza".uppercased()
        
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy),
            NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 77/255, blue: 69/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        cartLabel = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
        cartLabel.layer.borderColor = UIColor.clear.cgColor
        cartLabel.layer.borderWidth = 2
        cartLabel.layer.cornerRadius = cartLabel.bounds.size.height / 2
        cartLabel.textAlignment = .center
        cartLabel.layer.masksToBounds = true
        cartLabel.font = UIFont.systemFont(ofSize: 12)
        cartLabel.textColor = .white
        cartLabel.backgroundColor = .red
        cartLabel.isHidden = true
        
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        leftButton.setBackgroundImage(UIImage(named: "ic_cart_navbar"), for: .normal)
        leftButton.addTarget(self, action: #selector(cartButtonDidTap), for: .touchUpInside)
        leftButton.addSubview(cartLabel)
        
        let leftBarButtomItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtomItem
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        view.addSubview(popupMessageView)
        NSLayoutConstraint.activate([
            popupMessageView.topAnchor.constraint(equalTo: tableView.topAnchor),
            popupMessageView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            popupMessageView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
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
    }
    
    func displayFetchedPizzas(viewModelList: [Home.FetchPizza.PizzaViewModel], ingridients: [Home.FetchIngredients.Ingridient]) {
        pizzaList = viewModelList
        ingridientsList = ingridients
        tableView.reloadData()
    }
    
    func updateCartView(numberOfGoods: Int) {
        guard numberOfGoods > 0 else {
            cartLabel.isHidden = true
            return
        }
        
        cartLabel.text = "\(numberOfGoods)"
        cartLabel.isHidden = false
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pizzaList = pizzaList,
            let ingridientsList = ingridientsList
        else {
            return
        }
        router.showIngridients(for: pizzaList[indexPath.row], ingridients: ingridientsList)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath) as? PizzaCell,
              let pizzaList = pizzaList
        else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        cell.setupCell(viewModel: pizzaList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HomeViewController: PizzaCellDelegate {
    func didTapPriceView(for pizzaModel: Home.FetchPizza.PizzaViewModel) {
        output.saveToCart(pizzaModel: pizzaModel)
        output.checkCart()
        
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

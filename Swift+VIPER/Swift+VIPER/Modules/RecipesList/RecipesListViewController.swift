//
//  RecipesListViewController.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

final class RecipesListViewController: UIViewController {
    var presenter: RecipesListPresenterProtocol?
    
    private var recipes: [Recipe] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    private func setupViews() {
        title = "Recipes"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(loadingView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension RecipesListViewController: RecipesListViewProtocol {
    func showRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
        tableView.reloadData()
    }
    
    func showLoading() {
        loadingView.startAnimating()
        tableView.isHidden = true
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
        tableView.isHidden = false
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = recipes[indexPath.row]
        presenter?.didSelectRecipe(recipe)
    }
}

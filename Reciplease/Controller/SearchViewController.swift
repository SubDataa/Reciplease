//
//  WelcomeViewController.swift
//  Reciplease
//
//  Created by Thibault Ballof on 21/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    var ingredients: [String] = []
    
    //MARK: -Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        if let ingredientTextField = ingredientTextField.text {
            ingredients.append(ingredientTextField)
            tableView.reloadData()
        }
        ingredientTextField.text = ""
    }
    
    
    
    @IBAction func clearButton(_ sender: Any) {
        ingredients = []
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ingredients == [] {
            let alert = UIAlertController(title: "Missing ingredients", message: "You must add ingredients before continuing.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        guard let RecipeVC = segue.destination as? RecipeViewController else { return }
        RecipeVC.ingredients = ingredients
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = "\(ingredients[indexPath.row])"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
}




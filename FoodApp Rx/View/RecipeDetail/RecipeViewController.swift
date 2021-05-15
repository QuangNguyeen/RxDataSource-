//
//  RecipeViewController.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RecipeViewController: UIViewController {

    typealias DataSource = RxTableViewSectionedReloadDataSource<RecipeSectionModel>
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
    var dataSource: DataSource!
    var viewModel: RecipeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        
        registerCell()
        setupDataSource()
    }
    
    private func registerCell() {
        tableView.register(cellType: ImageTableViewCell.self)
        tableView.register(cellType: AboutTableViewCell.self)
        tableView.register(cellType: IngredientTableViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = DataSource(configureCell: configureCell)
    }
}

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 260
        case 1,2: return 40
        case 3: return 120
        default: return 0
        }
    }
}

extension RecipeViewController: BindableType {
    func bindViewModel() {
        bindDataSource()
        bindSectionModels()
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        viewModel.dataSource
            .map {$0.name}
            .drive(self.rx.title)
            .disposed(by: bag)
        
    }
    
    private func bindDataSource() {
        viewModel.dataSource
            .drive(onNext: {[unowned self] recipe in
                self.viewModel.initSectionModel(withRecipe: recipe)
            })
            .disposed(by: bag)
    }
    
    private func bindSectionModels() {
        viewModel.sectionModels
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

// MARK: Data Source Configuration

extension RecipeViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { dataSource, tableView, indexPath, _ in
            switch dataSource[indexPath] {
            case .image(let imageData):
                var cell = tableView.dequeueReusableCell(for: indexPath) as ImageTableViewCell
                cell.bind(to: ImageCellViewModel(withData: imageData))
                return cell
            case .about(let text):
                var cell = tableView.dequeueReusableCell(for: indexPath) as AboutTableViewCell
                cell.bind(to: AboutCellViewModel(withText: text))
                return cell
            case .ingredients(let ingredients):
                var cell = tableView.dequeueReusableCell(for: indexPath) as IngredientTableViewCell
                cell.bind(to: IngredientsCellViewModel(withIngredients: ingredients))
                return cell
            }
            
        }
    }
}

//
//  RecipeListViewController.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class RecipeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    typealias  RecipeListSectionModel = AnimatableSectionModel<String, Recipe>
    
    private let bag = DisposeBag()
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>!
    var viewModel: RecipeListViewModel!
    
    private var editBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Recipes"
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        registerCell()
        setupDataSource()
    }
    
    private func registerCell() {
        tableView.register(cellType: RecipeListTableViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .left),
            configureCell: configureCell,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath
        )
    }
    
    private func setupNavigationBar() {
        editBarButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                        target: self,
                                        action: nil)
        
        navigationItem.rightBarButtonItems = [editBarButton]
    }

}

//bindata
extension RecipeListViewController: BindableType {
    func bindViewModel() {
        bindDataSource()
        bindDeleted()
        bindMoved()
        bindSelected()
        bindNavigationBar()
    }
    
    private func bindDataSource() {
        viewModel.dataSource.asDriver()
            .map { [RecipeListSectionModel(model: "", items: $0)]}
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func bindDeleted() {
        tableView.rx.itemDeleted.asDriver()
            .drive(onNext: { [unowned self] indexPath in
                self.viewModel.dataSource.remove(at: indexPath.row)
            })
            .disposed(by: bag)
    }
    
    private func bindMoved() {
        tableView.rx.itemMoved.asDriver()
            .drive(onNext: { [unowned self] source, destination in
                guard source != destination else {return}
                let item = self.viewModel.dataSource.value[source.row]
                self.viewModel.dataSource.replaceElement(at: source.row, insertTo: destination.row, with: item)
            })
            .disposed(by: bag)
    }
    
    private func bindSelected() {
        tableView.rx.modelSelected(Recipe.self)
            .asDriver()
            .drive(onNext: {[unowned self] recipe in
                var vc = RecipeViewController()
                vc.bind(to: RecipeViewModel(withRecipe: recipe))
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: bag)
    }
    
    private func bindNavigationBar() {
        editBarButton.rx.tap.asDriver()
            .map { [unowned self] in
                self.tableView.isEditing
            }
            .drive(onNext: { [unowned self] result in
                self.tableView.setEditing(!result, animated: true)
            })
            .disposed(by: bag)
    }
}

extension RecipeListViewController {
    
    private var configureCell: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, recipe in
            var cell = tableView.dequeueReusableCell(for: indexPath) as RecipeListTableViewCell
            cell.bind(to: RecipeListCellViewModel(withRecipe: recipe))
            return cell
        }
    }
    
    private var canEditRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.CanEditRowAtIndexPath {
        return { [unowned self] _, _ in
            if self.tableView.isEditing {
                return true
            } else {
                return false
            }
        }
    }
    
    private var canMoveRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.CanMoveRowAtIndexPath {
        return { _, _ in
            return true
        }
    }
    
}

//
//  IngredientTableViewCell.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import RxDataSources

class IngredientTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias CellSectionModel = SectionModel<String, Ingredient>
    
    private let bag = DisposeBag()
    
    var viewModel: IngredientsCellViewModel!
    var dataSource: RxCollectionViewSectionedReloadDataSource<CellSectionModel>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        registerCell()
        setupDataSource()
    }
    
    private func registerCell() {
        collectionView.register(cellType: IngredientCollectionViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<CellSectionModel>(
            configureCell: configureCell
        )
    }
}

extension IngredientTableViewCell: BindableType {
    func bindViewModel() {
        bindDataSource()
        
        collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    private func bindDataSource() {
        viewModel.dataSource.asDriver()
            .map { [CellSectionModel(model: "", items: $0)] }
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

// MARK: Data Source Configuration

extension IngredientTableViewCell {
    private var configureCell: RxCollectionViewSectionedReloadDataSource<CellSectionModel>.ConfigureCell {
        return { _, collectionView, indexPath, ingredient in
            var cell = collectionView.dequeueReusableCell(for: indexPath) as IngredientCollectionViewCell
            cell.bind(to: IngredientCellViewModel(withData: ingredient.image))
            return cell
        }
    }
}

extension IngredientTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }
}

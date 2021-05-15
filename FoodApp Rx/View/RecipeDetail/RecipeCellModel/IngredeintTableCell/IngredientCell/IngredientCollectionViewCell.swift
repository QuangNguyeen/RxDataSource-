//
//  IngredientCollectionViewCell.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class IngredientCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var ingredientImage: UIImageView!
    
    private let bag = DisposeBag()
    
    var viewModel: IngredientCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientImage.layer.masksToBounds = true
        ingredientImage.layer.cornerRadius = 5
        ingredientImage.layer.borderWidth = 1
        ingredientImage.layer.borderColor = UIColor.darkGray.cgColor
    }
}

extension IngredientCollectionViewCell: BindableType {
    func bindViewModel() {
        viewModel.imageData.map { UIImage(data: $0) }
            .drive(ingredientImage.rx.image)
            .disposed(by: bag)
    }
}

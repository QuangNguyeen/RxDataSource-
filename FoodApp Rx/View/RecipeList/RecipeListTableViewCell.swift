//
//  RecipeListTableViewCell.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class RecipeListTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLable: UILabel!
    @IBOutlet weak var isVegetableLabel: UILabel!
    
    var viewModel: RecipeListCellViewModel!
    
    private let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.masksToBounds = true
        recipeImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension RecipeListTableViewCell: BindableType {
    func bindViewModel() {
        viewModel.name
            .drive(nameLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.calories
            .drive(caloriesLable.rx.text)
            .disposed(by: bag)
        
        viewModel.isVegetarian
            .map {
                if $0 {
                    return "Vegetarian"
                } else {
                    return "Non-vegetarian"
                }
            }
            .drive(isVegetableLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.imageData.map { UIImage(data: $0)}
            .drive(recipeImage.rx.image)
            .disposed(by: bag)
    }
}

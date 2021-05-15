//
//  ImageTableViewCell.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class ImageTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var recipeImage: UIImageView!
    
    private let bag = DisposeBag()
    
    var viewModel: ImageCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
        recipeImage.layer.masksToBounds = true
        recipeImage.layer.cornerRadius = 15
        recipeImage.layer.borderWidth = 1
        recipeImage.layer.borderColor = UIColor.darkGray.cgColor
    }
}

extension ImageTableViewCell: BindableType {
    func bindViewModel() {
        viewModel.imageData.map { UIImage(data: $0) }
            .drive(recipeImage.rx.image)
            .disposed(by: bag)
    }
}

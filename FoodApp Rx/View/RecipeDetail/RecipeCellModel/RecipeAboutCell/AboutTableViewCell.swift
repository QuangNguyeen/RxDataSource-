//
//  AboutTableViewCell.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class AboutTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var aboutLabel: UILabel!
    
    private let bag = DisposeBag()
    
    var viewModel: AboutCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension AboutTableViewCell: BindableType {
    func bindViewModel() {
        viewModel.text
            .drive(aboutLabel.rx.text)
            .disposed(by: bag)
    }
}

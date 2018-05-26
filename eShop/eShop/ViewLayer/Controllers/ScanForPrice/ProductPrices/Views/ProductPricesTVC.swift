//
//  ShopPriceTVC.swift
//  eShop
//
//  Created by 08APO0516 on 15/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxCocoa
import RxSwift

class ProductPricesTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var txtValue: UITextField!
    //@IBOutlet weak var lblValue: UILabel!
    
    // MARK: - Callbacks
    var onEditingEnd: ((ShopPriceContentField, String? ) -> Void) = { _ ,_  in }
    
    // MARK: - Public attribures
    var key:String = "" {
        didSet {
            lblKey.text = key
        }
    }
    
    var value:String = "" {
        didSet {
            txtValue.text = value
        }
    }
    
    var shopPriceContentField = ShopPriceContentField.count
    
    // MARK: - Private attributes
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private / Intrnal
    private func setupView() {
        /*
        txtValue.rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self,
                let _text = weakSelf.txtValue.text else { return }
            
            weakSelf._trimTextAndReadMode(text:_text)
        }).disposed(by: disposeBag)
 */
        
    }

}

//
//  ShopPriceTVC.swift
//  eShop
//
//  Created by 08APO0516 on 15/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxCocoa
import RxSwift

class ShopPriceTVC: UITableViewCell, UITextFieldDelegate {

    // MARK: - IBOutlet
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var svwLine: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    
    // MARK: - Callbacks
    var onEditingEnd: ((ShopPriceContentField) -> Void) = { _  in }
    
    // MARK: - Public attribures
    var shopPriceContentField = ShopPriceContentField.count {
        didSet {
            self._refreshView()
        }
    }
    
    // MARK :- Private attributes
    private var isEditMode = false
    
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
        self.backgroundColor = UIColor.clear
        
        svwLine.backgroundColor = ColorsEShop.ShopPrice.FontColor
        
        txtValue.borderStyle = .none
        
        txtValue.rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self,
                let _text = weakSelf.txtValue.text else {
                    return
                    
                }
                /*
                 ShopPriceContentField.shopName(price?.shop?.name),
                 ShopPriceContentField.productName(price?.product?.name),
                 ShopPriceContentField.priceValue(price?.price)
 */
                switch weakSelf.shopPriceContentField {
                case .shopName:  weakSelf.onEditingEnd(ShopPriceContentField.shopName(_text))
                case .productName:  weakSelf.onEditingEnd(ShopPriceContentField.productName(_text))
                case .priceValue:  weakSelf.onEditingEnd(ShopPriceContentField.priceValue(_text))
                case .count: return
                }
                
            //weakSelf._trimTextAndReadMode(text:_text)
               // weakSelf.onEditingEnd(weakSelf.shopPriceContentField, _text)
                
                weakSelf.isEditMode = false
                weakSelf._refreshView()
                
        }).disposed(by: disposeBag)
        
        
        txtValue.rx
            .controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                
                //weakSelf._trimTextAndReadMode(text:weakSelf.txtValue.text!)
               /* weakSelf.onEditingEnd(weakSelf.shopPriceContentField, weakSelf.txtValue.text ?? weakSelf.shopPriceContentField.emptyValue())*/
                weakSelf.isEditMode = true
                weakSelf._refreshView()
                
            }).disposed(by: disposeBag)
        
        
        
        btnRemove.setImage(R.image.img_edit(), for: .normal)
        btnRemove.setImage(R.image.img_close(), for: .selected)
        btnRemove.rx.tap.bind { [weak self] _ in
            guard let weakSelf = self else { return }
            
            if weakSelf.btnRemove.isSelected {
                weakSelf.txtValue.text = ""
            }
            weakSelf.isEditMode = true
            weakSelf._refreshView()
        }
        
    }
    
    func _refreshView() {
        
        imgIcon.image = shopPriceContentField.icon()
        imgIcon.contentMode = .scaleAspectFit
        
        if (txtValue.text?.isEmpty)! && self.isEditMode == false {
            txtValue.text = shopPriceContentField.value() ?? ""
        }
        
        self.txtValue.font = shopPriceContentField.font()
        self.txtValue.textColor = ColorsEShop.ShopPrice.FontColor
        self.txtValue.placeholder = shopPriceContentField.key()
        self.txtValue.keyboardType = shopPriceContentField.keyboardType()
        
        btnRemove.isSelected = isEditMode
        
        svwLine.isHidden = isEditMode == false
        
        if isEditMode {
            txtValue.becomeFirstResponder()
        } else {
            self.endEditing(true)
        }
    }
    
    func _trimTextAndReadMode(text:String) {
      //  guard let _machine = machine else { return }
        
        var _text = String(text)
        _text = _text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtValue.text = _text
        self.onEditingEnd(self.shopPriceContentField)
        /*
        self.onNewMachineName(_text)
        self.isEditMode = false
        self._refreshView()
 */
    }


}

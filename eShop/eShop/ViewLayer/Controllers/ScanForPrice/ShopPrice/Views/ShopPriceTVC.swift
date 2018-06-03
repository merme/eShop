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
    
    
    // MARK: - Callbacks
    var onEditingEnd: ((ShopPriceContentField, String? ) -> Void) = { _ ,_  in }
    
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
        txtValue.borderStyle = .none
        
        txtValue.rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self,
                let _text = weakSelf.txtValue.text else { return }
                
            //weakSelf._trimTextAndReadMode(text:_text)
                weakSelf.onEditingEnd(weakSelf.shopPriceContentField, _text)
                
                weakSelf.isEditMode = false
                weakSelf._refreshView()
                
        }).disposed(by: disposeBag)
        
        
        txtValue.rx
            .controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                
                //weakSelf._trimTextAndReadMode(text:weakSelf.txtValue.text!)
                weakSelf.onEditingEnd(weakSelf.shopPriceContentField, weakSelf.txtValue.text ?? weakSelf.shopPriceContentField.emptyValue())
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
        
        if (txtValue.text?.isEmpty)! && self.isEditMode == false {
            txtValue.text = shopPriceContentField.value() ?? ""
        }
        
        self.txtValue.font = shopPriceContentField.font()
        self.txtValue.textColor = UIColor.white
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
        self.onEditingEnd(self.shopPriceContentField, _text.isEmpty ? nil : _text)
        /*
        self.onNewMachineName(_text)
        self.isEditMode = false
        self._refreshView()
 */
    }


}

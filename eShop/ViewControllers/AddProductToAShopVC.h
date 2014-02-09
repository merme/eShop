//
//  AddProductToAShopVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModalViewDelegate;

@interface AddProductToAShopVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    id<ModalViewDelegate> delegate;
    
}


@property id<ModalViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pckPendingProducts;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblUnits;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectProduct;
@property (weak, nonatomic) IBOutlet UIImageView *bview;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (strong, nonatomic) IBOutlet UIView *vLocalView;
@property (strong, nonatomic) UITapGestureRecognizer *singleTap;


@property NSArray *arrShopPendingProducts;
@property NSArray *arrPriceType;


@end

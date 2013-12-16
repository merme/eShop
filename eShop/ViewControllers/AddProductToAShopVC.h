//
//  AddProductToAShopVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModalViewDelegate;

@interface AddProductToAShopVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>{
    
    id<ModalViewDelegate> delegate;
    
}


@property id<ModalViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pckPendingProducts;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;

@property NSArray *arrShopPendingProducts;


@end

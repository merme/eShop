//
//  EditProductVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 26/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProductVC : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bview;


@property (weak, nonatomic) IBOutlet UILabel *lblBarCode;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UIPickerView *pckTypePrice;

@property (strong, nonatomic) UITapGestureRecognizer *singleTap;

@property NSArray *arrPriceType;

-(IBAction)ReturnKeyButton:(id)sender;



@end

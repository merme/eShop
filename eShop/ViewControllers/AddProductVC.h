//
//  AddProductVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductVC : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIPickerView *pckPriceType;
@property (weak, nonatomic) IBOutlet UITextField *txtBarCode;
@property (weak, nonatomic) IBOutlet UILabel *lblBarCode;
@property (weak, nonatomic) IBOutlet UIImageView *bview;
@property (weak, nonatomic) IBOutlet UILabel *lblComparationUnit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (strong, nonatomic) UITapGestureRecognizer *singleTap;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;

@property (weak, nonatomic) IBOutlet UINavigationItem *barTop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCamera;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCatalog;

@property bool bPicture;

@property NSArray *arrPriceType;

-(void) setBarCode:(NSString*)p_sBarCode;

@end

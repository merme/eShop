//
//  EditProductVC.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 26/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProductVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

-(IBAction)ReturnKeyButton:(id)sender;
 
@end

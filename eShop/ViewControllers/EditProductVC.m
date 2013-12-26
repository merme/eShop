//
//  EditProductVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 26/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "EditProductVC.h"
#import "CCoreManager.h"
#import "CProduct.h"
#import "ProductListVC.h"


@interface EditProductVC ()

@end

@implementation EditProductVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Set label tags
    [self.lblName setText:NSLocalizedString(@"NAME", nil)];
    [self.btnSave setTitle:NSLocalizedString(@"SAVE", nil)];
    
    CProduct *cProduct = [CCoreManager getActiveProduct];
    [self.txtName setText:cProduct.sName];
    [self.txtName.delegate self];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSave:(id)sender {
    
    if([[self.txtName text] length]>0 ){
        
        CProduct *cProduct = [CCoreManager getActiveProduct];
        cProduct.sName= [self.txtName text];
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager updateProduct:cProduct];
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromEditProduct"]){
        if([[self.txtName text] length]>0 ){
            
            CProduct *cProduct = [CCoreManager getActiveProduct];
            cProduct.sName= [self.txtName text];
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager updateProduct:cProduct];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
    //Refresh shop list view
    [[ProductListVC sharedViewController] refreshProductList];
}

-(IBAction)ReturnKeyButton:(id)sender{
    [sender resignFirstResponder];
}




@end

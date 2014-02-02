//
//  EditShopVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "EditShopVC.h"
#import "CShop.h"
#import "CCoreManager.h"
#import "ShopsListVC.h"

@interface EditShopVC ()

@end

@implementation EditShopVC

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
    [self.lblLocation setText:NSLocalizedString(@"LOCATION", nil)];
    [self.btnSave setTitle:NSLocalizedString(@"SAVE", nil)];
    
    
    
    CShop *cShop = [CCoreManager getActiveShop];
    [self.txtName setText:cShop.sName];
    [self.txtLocation setText:cShop.sLocation];
    
    [self.lblId setText:[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"FISCAL_ID", nil),cShop.sId]];
    
    
    if(cShop.dPicture!=nil){
        self.uiImageView.image= [UIImage imageWithData:cShop.dPicture ];
        
    }
     
    
    
    
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnSave:(id)sender {
    if([[self.txtName text] length]>0 &&
       [[self.txtLocation text] length]>0){
        
        CShop *cShop = [CCoreManager getActiveShop];
        cShop.sName= [self.txtName text];
        cShop.sLocation=[self.txtLocation text];
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager updateShop:cShop];
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//Capture when Update navigation back key is pressed
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
 

    //Refresh shop list view
    //[[ShopsListVC sharedViewController] refreshShopList];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromEditSave"]){
        if([[self.txtName text] length]>0 &&
           [[self.txtLocation text] length]>0){
            
            CShop *cShop = [CCoreManager getActiveShop];
            cShop.sName= [self.txtName text];
            cShop.sLocation=[self.txtLocation text];
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager updateShop:cShop];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
    //Refresh shop list view
    [[ShopsListVC sharedViewController] refreshShopList];
}

-(IBAction)ReturnKeyButton:(id)sender{
    [sender resignFirstResponder];
}

@end

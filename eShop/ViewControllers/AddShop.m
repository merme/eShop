//
//  AddShop.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 28/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AddShop.h"
#import "CShop.h"
#import "CCoreManager.h"
#import "ShopsListVC.h"


@interface AddShop ()

@end

@implementation AddShop


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
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil)];
    [self.lblName setText:NSLocalizedString(@"NAME", nil)];
    [self.lblLocation setText:NSLocalizedString(@"LOCATION", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAddShopSave"]){
        if([[self.txtName text] length]>0 &&
           [[self.txtLocation text] length]>0){
            
            CShop *cShop = [[CShop alloc]init];
            cShop.sName= [self.txtName text];
            cShop.sLocation= [self.txtLocation text];
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager addShop:cShop];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //Refresh shop list view
    [[ShopsListVC sharedViewController] refreshShopList];
}

//Picker vier interface methods: END
- (IBAction)ReturnKeyButton:(id)sender {
    [sender resignFirstResponder];
}
@end

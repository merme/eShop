//
//  AddShopToAProduct.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AddShopToAProductVC.h"
#import "CCoreManager.h"
#import "ProductListPricesVC.h"
#import "CShop.h"
#import "ProductListPricesVC.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

@interface AddShopToAProductVC ()

@end


@implementation AddShopToAProductVC

@synthesize delegate;
@synthesize arrProductPendingShops;
@synthesize singleTap;

int iPickerShopViewRow=0;

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
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"Add Shop to a Product"];
    // Send the screen view.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createAppView] build]];
    
    //Request CCoreManager for pending produts
    arrProductPendingShops =[CCoreManager getProductNotExistingShops];
    
    //Setting callbacks for picker view
    [self.pckPendingProducts setDataSource:self];
    [self.pckPendingProducts setDelegate:self];
    
    //Setting label texts
    [self.lblSelectShop setText:NSLocalizedString(@"SELECT_SHOP", nil)];
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil)];
    [self.barTop setTitle:NSLocalizedString(@"ADD_SHOP", nil)];
    
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    
    //For hidding keyboar
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    //Initialize shop image, if necessary
    CProductPrice *cProductPrice =[arrProductPendingShops objectAtIndex:0];
    if([cProductPrice.dPicture length]>0){
        self.uiImageView.image= [UIImage imageWithData:cProductPrice.dPicture ];
    }
    
    //Validate form
    self.btnSave.enabled=NO;
    
}

// Selector method for hiding keyboard:BEGIN
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeGestureRecognizer:singleTap];
    [self.txtPrice resignFirstResponder];
    
    //Validate form
    [self validateForm];
    
}
- (IBAction)txtPriceEditingDidBegin:(id)sender {
        [self.view addGestureRecognizer:singleTap];
}
// Selector method for hiding keyboard:END

- (IBAction)txtPriceEditingDidEnd:(id)sender {
    //Validate form
    [self validateForm];
}


-(void) validateForm{
    //Check if the shop has any product to add in its list
    self.btnSave.enabled=([self.txtPrice text]>0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Picker view interface methods: BEGIN
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [arrProductPendingShops count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    CProductPrice *cProductPrice= [arrProductPendingShops objectAtIndex:row];
    
    NSString *S=[[NSString alloc] initWithFormat:@"%@ - %@", cProductPrice.sShopName,cProductPrice.sShopLocation];
    
    if([cProductPrice.dPicture length]>0){
        self.uiImageView.image= [UIImage imageWithData:cProductPrice.dPicture ];
        self.uiImageView.hidden=NO;
    }
    else{
        self.uiImageView.hidden=YES;
        
    }
    
    return S;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    iPickerShopViewRow=row;
    
    CProductPrice *cProductPrice =[arrProductPendingShops objectAtIndex:row];
    
    if([cProductPrice.dPicture length]>0){
        self.uiImageView.hidden=NO;
        self.uiImageView.image= [UIImage imageWithData:cProductPrice.dPicture ];
    }
    else{
        self.uiImageView.hidden=YES;
    }
    
}

//Picker vier interface methods: END

- (IBAction)btnSave:(id)sender {
    
    if([[self.txtPrice text] length]>0){
        //Get the current cProductPrice
        CProductPrice *cProductPrice =[arrProductPendingShops objectAtIndex:iPickerShopViewRow];
        
        
        //Look out only "." is accecpted as decimal in db, not "," comma
        NSString *sPrice =[self.txtPrice text];
        sPrice = [sPrice stringByReplacingOccurrencesOfString:@","
                                             withString:@"."];
        cProductPrice.fPrice= [sPrice floatValue];
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager insertShopPrice:cProductPrice];
            
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
        
        //Refresh shop list view
        [[ProductListPricesVC sharedProductListPricesVC] refreshProductShopPrices];
        
        
        [self performSegueWithIdentifier:@"backFromAddShop" sender:sender];
 

    }
}

//Capture when Update navigation back key is pressed
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    
    //Refresh shop list view
    [[ProductListPricesVC sharedProductListPricesVC] refreshProductShopPrices];
    
}

@end

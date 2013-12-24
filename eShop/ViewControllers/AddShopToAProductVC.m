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

@interface AddShopToAProductVC ()

@end


@implementation AddShopToAProductVC

@synthesize delegate;
@synthesize arrProductPendingShops;

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
    
    //Request CCoreManager for pending produts
    arrProductPendingShops =[CCoreManager getProductNotExistingShops];
    
    //Setting callbacks for picker view
    [self.pckPendingProducts setDataSource:self];
    [self.pckPendingProducts setDelegate:self];
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
    
    return S;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    iPickerShopViewRow=row;
}

//Picker vier interface methods: END

- (IBAction)btnSave:(id)sender {
    
    if([[self.txtPrice text] length]>0){
        //Get the current cProductPrice
        CProductPrice *cProductPrice =[arrProductPendingShops objectAtIndex:iPickerShopViewRow];

        cProductPrice.fPrice= [[self.txtPrice text] floatValue];
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager insertShopPrice:cProductPrice];
            
        
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
    [[ProductListPricesVC sharedProductListPricesVC] refreshProductShopPrices];
    
}

@end

//
//  AddProductToAShopVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AddProductToAShopVC.h"
#import "CCoreManager.h"
#import "CShop.h"
#import "CCoreManager.h"
#import "ShopListPricesVC.h"

@interface AddProductToAShopVC ()

@end

@implementation AddProductToAShopVC

@synthesize delegate;
@synthesize arrShopPendingProducts;

int iPickerViewRow=0;

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
    arrShopPendingProducts =[CCoreManager getShopNotExistingProducts];
    
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
    return [arrShopPendingProducts count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    CShop *cShop= [arrShopPendingProducts objectAtIndex:row];
    
    return cShop.sName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    iPickerViewRow=row;
}

//Picker vier interface methods: END

- (IBAction)btnSave:(id)sender {
    
    if([[self.txtPrice text] length]>0){
        //Get the current cProductPrice
        CProductPrice *cProductPrice =[arrShopPendingProducts objectAtIndex:iPickerViewRow];
        cProductPrice.iId = cProductPrice.iId;
        cProductPrice.sName = cProductPrice.sName;
        cProductPrice.fPrice= [[self.txtPrice text] floatValue];
    
        //Request to CCoreManager to store new Product-Price
        [CCoreManager insertProductPrice:cProductPrice];
        

    
   
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
    [[ShopListPricesVC sharedShopListPricesVC] refreshShopProductPrices];
    
}

- (IBAction)txtPriceEditingDidEnd:(id)sender {
    NSLog(@"txtPriceEditingDidEnd");
}


@end

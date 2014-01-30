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
@synthesize arrPriceType;

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
    
    //Setting label texts
    [self.lblPrice setText:NSLocalizedString(@"PRICE", nil)];
    [self.lblSelectProduct setText:NSLocalizedString(@"SELECT_PRODUCT", nil)];
    
    //Initialize price type array
    arrPriceType=PRICE_TYPES;
    CProductPrice *cProductPrice =[arrShopPendingProducts objectAtIndex:0];
    /*
    [self.lblUnits setText:[[NSString alloc]initWithFormat:@"%@: %@", NSLocalizedString(@"UNITS", nil),arrPriceType[cProductPrice.tPriceType]]];
    */
    [self.lblUnits setText:[[NSString alloc]initWithFormat:@"%@",arrPriceType[cProductPrice.tPriceType]]];
    
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
    
    CProductPrice *cProductPrice =[arrShopPendingProducts objectAtIndex:row];
    
    [self.lblUnits setText:[[NSString alloc]initWithFormat:@"%@",arrPriceType[cProductPrice.tPriceType]]];
}

//Picker vier interface methods: END

- (IBAction)btnSave:(id)sender {
    
    if([[self.txtPrice text] length]>0){
        //Get the current cProductPrice
        CProductPrice *cProductPrice =[arrShopPendingProducts objectAtIndex:iPickerViewRow];
        cProductPrice.iId = cProductPrice.iId;
        cProductPrice.sName = cProductPrice.sName;
        
        //Look out only "." is accecpted as decimal in db, not "," comma
        NSString *sPrice =[self.txtPrice text];
        sPrice = [sPrice stringByReplacingOccurrencesOfString:@","
                                                   withString:@"."];
        cProductPrice.fPrice= [sPrice floatValue];
        
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

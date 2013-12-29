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

@synthesize arrPriceType;

int iPickerPriceTypeOnEditRow=0;



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
    
    //Initialize price type array
    arrPriceType=PRICE_TYPES;
    
    // Set label tags
    [self.lblName setText:NSLocalizedString(@"NAME", nil)];
    [self.btnSave setTitle:NSLocalizedString(@"SAVE", nil)];
    
    CProduct *cProduct = [CCoreManager getActiveProduct];
    [self.txtName setText:cProduct.sName];
    [self.txtName.delegate self];
    
    //Setting callbacks for picker view
    [self.pckTypePrice setDataSource:self];
    [self.pckTypePrice setDelegate:self];
    [self.pckTypePrice selectRow:cProduct.tPriceType inComponent:0 animated:YES];
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnSaveProduct:(id)sender {
    if([[self.txtName text] length]>0 ){
        
        CProduct *cProduct = [CCoreManager getActiveProduct];
        cProduct.sName= [self.txtName text];
        cProduct.tPriceType =iPickerPriceTypeOnEditRow;
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager updateProduct:cProduct];
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
        
        [self performSegueWithIdentifier:@"backFromEditProductSave" sender:sender];
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromEditProductSave"]){
        if([[self.txtName text] length]>0 ){
            
            CProduct *cProduct = [CCoreManager getActiveProduct];
            cProduct.sName= [self.txtName text];
            cProduct.tPriceType =iPickerPriceTypeOnEditRow;
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager updateProduct:cProduct];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    
    //Refresh shop list view
    [[ProductListVC sharedViewController] refreshProductList];
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

    
    return [arrPriceType count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [arrPriceType objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    iPickerPriceTypeOnEditRow=row;
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAdProductSave"]){
        if([[self.txtName text] length]>0 ){
            
            CProduct *cProduct = [[CProduct alloc]init];
            cProduct.sName= [self.txtName text];
            cProduct.tPriceType =iPickerPriceTypeRow;
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager addProduct:cProduct];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
 
    
    //Refresh shop list view
    [[ProductListVC sharedViewController] refreshProductList];
}
*/
-(IBAction)ReturnKeyButton:(id)sender{
    [sender resignFirstResponder];
}




@end

//
//  AddProductVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AddProductVC.h"
#import "CProduct.h"
#import "ProductListVC.h"
#import "CCoreManager.h"

@interface AddProductVC ()


@end

static NSString* sBarCode;

@implementation AddProductVC

int iPickerPriceTypeRow=0;

@synthesize arrPriceType;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        sBarCode=nil;
        self.btnSave.enabled=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Initialize price type array
    arrPriceType=PRICE_TYPES;
    

    //Setting callbacks for picker view
    [self.pckPriceType setDataSource:self];
    [self.pckPriceType setDelegate:self];
    
    // Set label tags
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil)];
    [self.lblName setText:NSLocalizedString(@"NAME", nil)];
    [self.lblBarCode setText:NSLocalizedString(@"BAR_CODE", nil)];
    [self.lblComparationUnit setText:NSLocalizedString(@"COMP_UNIT", nil)];
    
    if(sBarCode!=nil){
        [self.txtBarCode setText:sBarCode];
    }
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.bview.backgroundColor = background;
    
    [self validateForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBarCode:(id)sender {
    sBarCode=nil;
}

-(void) setBarCode:(NSString*)p_sBarCode{
    
    if(sBarCode==nil){
        sBarCode=p_sBarCode;
    }

    [self reloadInputViews];
}

- (IBAction)btnTextEditingDidEnd:(id)sender {
    //sBarCode=self.txtBarCode.text;
    [self validateForm];
}

- (IBAction)btnTextNameEditingDidEnd:(id)sender {
     [self validateForm];
}


-(void) validateForm{
    // [self.txtBarCode setText:sBarCode];
    
    self.btnSave.enabled=([self.txtName.text length]>0 &&
        [self.txtBarCode.text length]>0);
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
    iPickerPriceTypeRow=row;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAddProductSave"]){
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

//Picker vier interface methods: END
- (IBAction)ReturnKeyButton:(id)sender {
    [sender resignFirstResponder];
}


@end

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
@synthesize singleTap;
@synthesize bPicture;

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
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil)];
    [self.barTop setTitle:NSLocalizedString(@"ADD_PROD", nil)];
    
    
    CProduct *cProduct = [CCoreManager getActiveProduct];
    [self.txtName setText:cProduct.sName];
    [self.txtName.delegate self];
    [self.lblBarCode setText:[NSString stringWithFormat:@"%@  %@",NSLocalizedString(@"BAR_CODE", nil),cProduct.sId]];
    if([cProduct.dPicture length]>0){
        self.uiImageView.image= [UIImage imageWithData:cProduct.dPicture ];
        
    }
    
    //Initialize image
    self.bPicture=FALSE;
    
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    
    //Setting callbacks for picker view
    [self.pckTypePrice setDataSource:self];
    [self.pckTypePrice setDelegate:self];
    [self.pckTypePrice selectRow:cProduct.tPriceType inComponent:0 animated:YES];
    
    //For hidding keyboar
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    
}

// Selector method for hiding keyboard:BEGIN
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeGestureRecognizer:singleTap];
    [self.txtName resignFirstResponder];

    
}
- (IBAction)txtEditingDidBegin:(id)sender {
        [self.view addGestureRecognizer:singleTap];
}
// Selector method for hiding keyboard:END

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
        
        //Set the image
        if(self.bPicture){
            cProduct.dPicture=UIImagePNGRepresentation(self.uiImageView.image);
        }
        else{
            cProduct.dPicture=nil;
        }
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager updateProduct:cProduct];
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
        
        [self performSegueWithIdentifier:@"backFromEditProduct" sender:sender];
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromEditProductSave"]){/*
        if([[self.txtName text] length]>0 ){
            
            CProduct *cProduct = [CCoreManager getActiveProduct];
            cProduct.sName= [self.txtName text];
            cProduct.tPriceType =iPickerPriceTypeOnEditRow;
            
            //Request to CCoreManager to store new Product-Price
            [CCoreManager updateProduct:cProduct];
            
            //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
            [self.navigationController popViewControllerAnimated:YES];
            
        }*/
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


//Camera and picture album:BEGIN
//http://www.appcoda.com/ios-programming-camera-iphone-app/
- (IBAction)btnTakePhoto:(id)sender  {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)btnSelectPhoto:(id)sender {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.uiImageView.image = chosenImage;
    
    self.bPicture=TRUE;
    /*
     //Manage save button status
     if (!btnSave.enabled){
     //Enable Save button if the value is different from previous one
     btnSave.enabled=TRUE;
     }
     */
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//Camera and picture album:END



@end

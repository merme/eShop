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
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

@interface AddProductVC ()


@end

static NSString* sBarCode;

@implementation AddProductVC

int iPickerPriceTypeRow=0;
bool bReadCodeBar=FALSE;
CProduct *cProdFound=nil;
NSString *sName=nil;

@synthesize arrPriceType;
@synthesize singleTap;



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
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [[GAI sharedInstance].defaultTracker set:kGAIScreenName
                                       value:@"Add Product"];
    // Send the screen view.
    [[GAI sharedInstance].defaultTracker
     send:[[GAIDictionaryBuilder createAppView] build]];
    
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
    [self.barTop setTitle:NSLocalizedString(@"ADD_PROD", nil)];

    [self.txtName setText:sName];
    

    
    if(bReadCodeBar){
        [self.txtBarCode setText:sBarCode];
        bReadCodeBar=FALSE;
        
        if(cProdFound!=nil){
            [self.txtName setText:cProdFound.sName];
            
            if([cProdFound.dPicture length]>0){
                self.uiImageView.image= [UIImage imageWithData:cProdFound.dPicture ];
            }
            
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"PROD_EXISTS", nil),cProdFound.sName,cProdFound.sId] delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
            
            [mes show];
            
            // Execute back segue
            [self performSegueWithIdentifier:@"backFromAddProduct" sender:self];
        }
    }
    else{
        [self.txtBarCode setText:@" "];
        
    }
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.bview.backgroundColor = background;
    
    //Initialize image
    self.bPicture=FALSE;
    
    [self validateForm];
    //For hidding keyboar
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];

}



// Selector method for hiding keyboard:BEGIN
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeGestureRecognizer:singleTap];
    [self.txtName resignFirstResponder];
    [self.txtBarCode resignFirstResponder];
}


- (IBAction)btnEditingDidBegin:(id)sender {
    [self.view addGestureRecognizer:singleTap];
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
        
        CProduct *cProdNew = [[CProduct alloc]init];
        cProdNew.sId=sBarCode;
        cProdFound = nil;
        cProdFound = [CCoreManager existsProduct:cProdNew];
        
        [self reloadInputViews];
        
    }

  
}

- (IBAction)btnTextEditingDidEnd:(id)sender {
    //sBarCode=self.txtBarCode.text;
    [self validateForm];
}




-(bool) validateForm{
    // [self.txtBarCode setText:sBarCode];
    
    self.btnSave.enabled=([self.txtName.text length]>0 &&
        [self.txtBarCode.text length]>0 && cProdFound==nil);
    self.btnCamera.enabled=(cProdFound==nil);
    self.btnCatalog.enabled=(cProdFound==nil);
    
    return self.btnSave.enabled;
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


- (IBAction)btnSave:(id)sender {
    
    [self saveProduct];
    
    // Execute back segue
    [self performSegueWithIdentifier:@"backFromAddProduct" sender:self];
    
}

-(void) saveProduct{
    CProduct *cProduct = [[CProduct alloc]init];
    cProduct.sId=[self.txtBarCode text];
    cProduct.sName= [self.txtName text];
    cProduct.tPriceType =iPickerPriceTypeRow;
        
    //Set the image
    if(self.bPicture){
        cProduct.dPicture=UIImagePNGRepresentation(self.uiImageView.image);
    }
    else{
        cProduct.dPicture=nil;
    }
        
    //Request to CCoreManager to store new Product-Price
    [CCoreManager addProduct:cProduct];
        
    //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnBack:(id)sender {
    
    
    if([self validateForm]){
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:NSLocalizedString(@"ATTENTION",nil)];
        [alert setMessage:NSLocalizedString(@"SAVE_PROD",nil)];
        [alert setDelegate:self];
        [alert addButtonWithTitle:NSLocalizedString(@"YES",nil)];
        [alert addButtonWithTitle:NSLocalizedString(@"NO",nil)];
        [alert show];
    }
    else{
        // Execute back segue
        [self performSegueWithIdentifier:@"backFromAddProduct" sender:self];
    }
    
    

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Yes, do something
        [self saveProduct];
    }
    
    // Execute back segue
    [self performSegueWithIdentifier:@"backFromAddProduct" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAddProduct"]){

         bReadCodeBar=FALSE;
         cProdFound=nil;
         sName=nil;
    }
    else if([segue.identifier isEqualToString:@"readCodeBar"]){
        bReadCodeBar=TRUE;
        
        sName=[NSString stringWithFormat:@"%@", self.txtName.text];
    }
    
    
    
    //Refresh shop list view
    [[ProductListVC sharedViewController] refreshProductList];
}

//Picker vier interface methods: END
- (IBAction)ReturnKeyButton:(id)sender {
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

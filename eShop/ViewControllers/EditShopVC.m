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

@synthesize singleTap;
@synthesize bPicture;

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
    [self.barTop setTitle:NSLocalizedString(@"EDIT_SHOP", nil)];
    [self.btnBack setTitle:NSLocalizedString(@"BACK", nil)];
    
    
    
    CShop *cShop = [CCoreManager getActiveShop];
    [self.txtName setText:cShop.sName];
    [self.txtLocation setText:cShop.sLocation];
    [self.lblId setText:[NSString stringWithFormat:@"%@  %@",NSLocalizedString(@"FISCAL_ID", nil),cShop.sId]];
    if([cShop.dPicture length]>0){
        self.uiImageView.image= [UIImage imageWithData:cShop.dPicture ];
        
    }
    
    //Initialize image
    self.bPicture=FALSE;
   
    
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    //For hidding keyboar
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    
}

// Selector method for hiding keyboard:BEGIN
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeGestureRecognizer:singleTap];
    [self.txtName resignFirstResponder];
    [self.txtLocation resignFirstResponder];
    
}

- (IBAction)txtNameEditingDidBeing:(id)sender {
    [self.view addGestureRecognizer:singleTap];
}

// Selector method for hiding keyboard:END


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSaveProduct:(id)sender {
    if([[self.txtName text] length]>0 &&
       [[self.txtLocation text] length]>0){
        
        CShop *cShop = [CCoreManager getActiveShop];
        cShop.sName= [self.txtName text];
        cShop.sLocation=[self.txtLocation text];
        
        //Set the image
        if(self.bPicture){
            cShop.dPicture=UIImagePNGRepresentation(self.uiImageView.image);
        }
        else{
            cShop.dPicture=nil;
        }
        
        //Request to CCoreManager to store new Product-Price
        [CCoreManager updateShop:cShop];
        
        //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
        [self.navigationController popViewControllerAnimated:YES];
        
        [self performSegueWithIdentifier:@"backFromEdit" sender:sender];
    }
}


//Capture when Update navigation back key is pressed
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
 

    //Refresh shop list view
    [[ShopsListVC sharedViewController] refreshShopList];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromEditSave"]){
        /*
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
         */
    }
    
    
    //Refresh shop list view
    [[ShopsListVC sharedViewController] refreshShopList];
}

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

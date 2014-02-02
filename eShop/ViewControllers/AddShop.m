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

@synthesize singleTap;


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
    [self.lblId setText:NSLocalizedString(@"FISCAL_ID", nil)];
    
    //Disable save button
    self.btnSave.enabled=NO;
    
    // Assign our own backgroud for the view
    self.bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    
    //Initialize image
    self.bPicture=FALSE;
    
    //For hidding keyboar
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    
}

// Selector method for hiding keyboard:BEGIN
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    
    [self.view removeGestureRecognizer:singleTap];
    [self.txtName resignFirstResponder];
    [self.txtLocation resignFirstResponder];
    [self.txtId resignFirstResponder];
    
}
- (IBAction)btnPriceEditingDidBegin:(id)sender {
   
}


- (IBAction)btnEditingDidBegin:(id)sender {
     [self.view addGestureRecognizer:singleTap];
}


// Selector method for hiding keyboard:END


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
            cShop.sId=[self.txtId text];
            cShop.sName= [self.txtName text];
            cShop.sLocation= [self.txtLocation text];
            
            //Set the image
            if(self.bPicture){
                cShop.dPicture=UIImagePNGRepresentation(self.uiImageView.image);
            }
            else{
                cShop.dPicture=nil;
            }
            
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
- (IBAction)txtIdEditingDidEnd:(id)sender {
    
    self.btnSave.enabled= ([self.txtId.text length]>0);
    
    // Hide keyboard
    [sender resignFirstResponder];
}
- (IBAction)txtIdDidEndOnExit:(id)sender {
    self.btnSave.enabled= ([self.txtId.text length]>0);
    
    // Hide keyboard
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

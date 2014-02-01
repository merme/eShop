//
//  ShopsListVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ShopsListVC.h"
//#import "AppDelegate.h"
#import "ShopViewCell.h"
#import "CShop.h"
#import "CProductPrice.h"
#import "CCoreManager.h"

static ShopsListVC *sharedInstance;

@interface ShopsListVC ()

@end

@implementation ShopsListVC

@synthesize arrShops;
@synthesize tbvShops;


-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    
    //Initialize singleton class
    sharedInstance=self;
    
    
    
    return self;
}

//Return a reference of this class
+(ShopsListVC *) sharedViewController{
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvShops setDataSource:self];
    [self.tbvShops setDelegate:self];
    // Assign our own backgroud for the view
/*    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    [self.tbvShops setBackgroundView:bview];
  */
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.tbvShops.backgroundColor = background;
    
    //self.tbvShops.backgroundView = tempImageView;

    
    
    //Request to AppDelegate list of avaliable shops
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrShops = [CCoreManager getShopsList];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// BEGIN: Methods to implement for fulfill CollectionView Interface
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrShops count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *CellIdentifier = @"CellShopId";
    
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CShop *currShop = [arrShops objectAtIndex:indexPath.row];
    
    [cell.lblName setText:[NSString stringWithFormat:@"%@",currShop.sName]];
    [cell.lblLocation setText:[NSString stringWithFormat:@"%@",currShop.sLocation]];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CShop* cCurrShop;
    
    // Get the current shop
    cCurrShop = [arrShops objectAtIndex:indexPath.row];
    
    //Notify CoreManager which is the active shop
    [CCoreManager setActiveShop:cCurrShop];
    
    [self performSegueWithIdentifier:@"showPriceProducts" sender:self.view];
    
   
 
}

//end: Methods to implement for fulfill CollectionView Interface

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPriceProducts"]){
 /*
        //Create a new prescription object
        Prescription *prescription;
        prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:tDosis Image:uiImageView.image];
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate addPrescription:prescription];
 */       
    }
}

-(void) refreshShopList{
    //Request to Core manager for prices of current shop
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrShops = [CCoreManager getShopsList];
    
    //Refresh whole table
    [self.tbvShops reloadData];
}



@end

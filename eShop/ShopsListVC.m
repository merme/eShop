//
//  ShopsListVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ShopsListVC.h"
#import "AppDelegate.h"
#import "ShopViewCell.h"
#import "CShop.h"

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
    
    
    //Request to AppDelegate list of avaliable shops
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrShops = [appDelegate getShopsList];
    
    
    NSLog(@"ss");
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
    
/*
    static NSString *CellIdentifier = @"CellShopId";
    
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                         
    if (cell == nil) {
        cell = [[ShopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    CShop *currShop = [arrShops objectAtIndex:indexPath.row];
    
    [cell.lblName setText:[NSString stringWithFormat:@"%@",currShop.sName]];
*/
    static NSString *CellIdentifier = @"CellShopId";
    
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CShop *currShop = [arrShops objectAtIndex:indexPath.row];
    
    [cell.lblName setText:[NSString stringWithFormat:@"%@",currShop.sName]];
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    // Get the medicine name
//    sMedicineName=[arrSampleMedicines objectAtIndex:indexPath.row];
//    sMedicineNamePng=[arrSampleMedicinesPng objectAtIndex:indexPath.row];
    
    
    //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
//    [self.navigationController popViewControllerAnimated:YES];
 
}

//end: Methods to implement for fulfill CollectionView Interface

@end

//
//  ShopListPricesVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ShopListPricesVC.h"
#import "CProductPrice.h"
#import "ShopPriceCell.h"
#import "CCoreManager.h"
#import "AddProductToAShopVC.h"
#import "CShop.h"

static ShopListPricesVC *sharedInstance;

@interface ShopListPricesVC ()

@end

@implementation ShopListPricesVC

@synthesize arrShopProductPrices;
@synthesize cProductPrice;


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
    
    sharedInstance=self;
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvShopProductPrices setDataSource:self];
    [self.tbvShopProductPrices setDelegate:self];
    
    //Request to Core manager for prices of current shop
    arrShopProductPrices=[CCoreManager getShopPriceList];
    
    //Check if the shop has any product to add in its list
    self.btnAdd.enabled=([CCoreManager getNumberShopNotExistingProducts]>0);
    
    //Set tittle text
    CShop *cShop=[CCoreManager getActiveShop];
    [self.barTop setTitle:[[NSString alloc] initWithFormat:@"%@ (%@)", cShop.sName,cShop.sLocation]];
    
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
    return [arrShopProductPrices count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"CellShopPriceId";
    
    
    ShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShopPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CProductPrice *currProductPrice = [arrShopProductPrices objectAtIndex:indexPath.row];
    
    [cell.lblProductName setText:[NSString stringWithFormat:@"%@",currProductPrice.sName]];
    [cell.txtPrice setText:[NSString stringWithFormat:@"%f",currProductPrice.fPrice]];
    [cell.lblCategory setText:[NSString stringWithFormat:@"%d",currProductPrice.tCategory]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    CShop* cCurrShop;
    
    // Get the current shop
    cCurrShop = [arrShops objectAtIndex:indexPath.row];
    
    //Notify CoreManager which is the active shop
    [CCoreManager setActiveShop:cCurrShop];
    
    //    sMedicineName=[arrSampleMedicines objectAtIndex:indexPath.row];
    //    sMedicineNamePng=[arrSampleMedicinesPng objectAtIndex:indexPath.row];
    
    
    //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
    [self.navigationController popViewControllerAnimated:YES];
   */
}

//end: Methods to implement for fulfill CollectionView Interface

-(void) refreshShopProductPrices{
    //Request to Core manager for prices of current shop
    arrShopProductPrices=[CCoreManager getShopPriceList];
    
    //Refresh whole table
    [self.tbvShopProductPrices reloadData];
}
/*
-(void) viewDidAppear:(BOOL)animated{
    //Refresh whole table
    [self.tbvShopProductPrices reloadData];
}
*/
// Return an instance of this class, in that way the ViewController can access to this class
+(ShopListPricesVC *) sharedShopListPricesVC{
    return sharedInstance;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromDeleteShop"]){
        
        //Remove current shop
        [CCoreManager deleteShop];

    }
    
}





@end

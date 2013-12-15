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

@interface ShopListPricesVC ()

@end

@implementation ShopListPricesVC

//Array of timers
@synthesize arrShopProductPrices;


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
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvShopProductPrices setDataSource:self];
    [self.tbvShopProductPrices setDelegate:self];
    
    //Request to Core manager for prices of current shop
    arrShopProductPrices=[CCoreManager getShopPriceList];
    
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

@end

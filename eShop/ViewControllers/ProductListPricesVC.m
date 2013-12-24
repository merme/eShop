//
//  ProductListPricesVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ProductListPricesVC.h"
#import "CProductPrice.h"
#import "CCoreManager.h"
#import "ProductPriceCell.h"
#import "ProductListVC.h"

static ProductListPricesVC *sharedInstance;

@interface ProductListPricesVC ()

@end

@implementation ProductListPricesVC

@synthesize arrProductShopPrices;
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
    [self.tbvProductShopPrices setDataSource:self];
    [self.tbvProductShopPrices setDelegate:self];

    //Request to Core manager for prices of current shop
    arrProductShopPrices=[CCoreManager getProductPriceList];
    
    //Check if the shop has any product to add in its list
    self.btnAdd.enabled=([CCoreManager getNumberProductNotExistingShops]>0);
    
    //Set tittle text
    CProduct *cProduct=[CCoreManager getActiveProduct];
    [self.barTop setTitle:[[NSString alloc] initWithFormat:@"%@", cProduct.sName]];
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
    return [arrProductShopPrices count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"CellProductPriceId";
    
    
    ProductPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ProductPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CProductPrice *currProductPrice = [arrProductShopPrices objectAtIndex:indexPath.row];
    
    [cell.lblShopName setText:[NSString stringWithFormat:@"%@",currProductPrice.sShopName]];
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

-(void) refreshProductShopPrices{
    //Request to Core manager for prices of current shop
    arrProductShopPrices=[CCoreManager getProductPriceList];
    
    //Refresh whole table
    [self.tbvProductShopPrices reloadData];
}


// Return an instance of this class, in that way the ViewController can access to this class
+(ProductListPricesVC *) sharedProductListPricesVC{
    return sharedInstance;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromDeleteProduct"]){
        
        //Remove current shop
        [CCoreManager deleteProduct];
        
        //Refresh shop list view
        [[ProductListVC sharedViewController] refreshProductList];
        
    }
    
}

@end

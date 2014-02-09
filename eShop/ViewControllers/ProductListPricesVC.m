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
static CProductPrice *m_currProductPrice;

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
    
    //Disable delete product button
    self.btnDel.enabled=NO;
    //Update button status
    [self toggleButtons];
    
    if([arrProductShopPrices count]==0 && !self.btnAdd.enabled){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                    message:NSLocalizedString(@"NO_SHOPS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
        
        [mes show];
        
    }
    else{
        if(!self.btnAdd.enabled){
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                        message:NSLocalizedString(@"ALL_SHOPS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
            
            [mes show];
        }
    }
    
    //Set tittle text
    CProduct *cProduct=[CCoreManager getActiveProduct];
    [self.barTop setTitle:[[NSString alloc] initWithFormat:@"%@", cProduct.sName]];
    [self.btnAdd setTitle:NSLocalizedString(@"SHOP_PRICE", nil)];
    
    //Set table background
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    self.tbvProductShopPrices.backgroundColor = background;
    
    //Initialize current ProductPrice
    m_currProductPrice=nil;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDeleteShopPrice:(id)sender {
    if(m_currProductPrice!=nil){
        
        //Remove current shop
        [CCoreManager deleteProductPrice:m_currProductPrice];
        
        //Refresh shop list view
        m_currProductPrice=nil;
        
        //Request to Core manager for prices of current shop
        arrProductShopPrices=[CCoreManager getProductPriceList];
        
        //Refresh whole table
        [self.tbvProductShopPrices reloadData];
        
        //Update button status
        [self toggleButtons];
        
    }
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
    [cell.lblCategory setText:[NSString stringWithFormat:@"%d",currProductPrice.tCategory]];    
    [cell.txtPrice setText:[NSString stringWithFormat:@"%0.2f",currProductPrice.fPrice]];
    [cell.lblPrice setText:[NSString stringWithFormat:@"%0.2f",currProductPrice.fPrice]];
    
    cell.txtPrice.hidden=!(m_currProductPrice!=nil && m_currProductPrice==currProductPrice);
    cell.lblPrice.hidden=!cell.txtPrice.hidden;
    cell.btnPrice.hidden=cell.txtPrice.hidden;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Set the current product price
    m_currProductPrice=nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the current product price
    m_currProductPrice=[arrProductShopPrices objectAtIndex:indexPath.row];
    
    //Update button status
    [self toggleButtons];
    
    [self.tbvProductShopPrices reloadData];
    

}

//end: Methods to implement for fulfill CollectionView Interface

-(void) refreshProductShopPrices{
    
    m_currProductPrice=nil;
    
    //Request to Core manager for prices of current shop
    arrProductShopPrices=[CCoreManager getProductPriceList];
    
    //Refresh whole table
    [self.tbvProductShopPrices reloadData];
    
    //Update button status
    [self toggleButtons];
    
    if([arrProductShopPrices count]==0 && !self.btnAdd.enabled){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                    message:NSLocalizedString(@"NO_SHOPS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
        
        [mes show];
        
    }
    else{
        if(!self.btnAdd.enabled){
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                        message:NSLocalizedString(@"ALL_SHOPS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
            
            [mes show];
        }
    }

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

+(void) setNewShopProductPrice:(NSString*)p_sPrice{
    
    if(m_currProductPrice!=nil){
        
        //Look out only "." is accecpted as decimal in db, not "," comma
        NSString *sPrice =p_sPrice;
        sPrice = [sPrice stringByReplacingOccurrencesOfString:@","
                                                   withString:@"."];
        m_currProductPrice.fPrice= [sPrice floatValue];
        
        [CCoreManager updateShopPrice:m_currProductPrice];
    }
    
}

-(void) toggleButtons{
    
    self.btnDel.enabled=(m_currProductPrice!=nil);
    self.btnAdd.enabled=!self.btnDel.enabled && ([CCoreManager getNumberProductNotExistingShops]!=0);;
    self.btnDelProduct.enabled=!self.btnDel.enabled;
    self.btnEditProduct.enabled=!self.btnDel.enabled;
}

@end

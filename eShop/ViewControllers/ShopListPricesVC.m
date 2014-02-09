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
#import "ShopsListVC.h"

static ShopListPricesVC *sharedInstance;
static CProductPrice *m_currProductPrice;

int iCurrProductPrice=-1;

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
   /* UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    [self.tbvShopProductPrices setBackgroundView:bview];
    */		
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    self.tbvShopProductPrices.backgroundColor = background;
    
    
    //Request to Core manager for prices of current shop
    arrShopProductPrices=[CCoreManager getShopPriceList];
    
    //Check if the shop has any product to add in its list
    self.btnAdd.enabled=([CCoreManager getNumberShopNotExistingProducts]>0);
    [self.btnAdd setTitle:NSLocalizedString(@"PRODUCT_PRICE", nil)];
    

    
    //Disable delete product button
    self.btnDel.enabled=NO;
    //Update button status
    [self toggleButtons];
    
    if([arrShopProductPrices count]==0 && !self.btnAdd.enabled){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                    message:NSLocalizedString(@"NO_PRODUCTS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
        
        [mes show];
        
    }
    else{
        if(!self.btnAdd.enabled){
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                        message:NSLocalizedString(@"ALL_PRODUCTS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
            
            [mes show];
        }
    }
    
    
    //Set tittle text
    CShop *cShop=[CCoreManager getActiveShop];
    [self.barTop setTitle:[[NSString alloc] initWithFormat:@"%@ (%@)", cShop.sName,cShop.sLocation]];
    
    //Initialize current ProductPrice
    m_currProductPrice=nil;
    
    
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
    [cell.txtPrice setText:[NSString stringWithFormat:@"%0.2f",currProductPrice.fPrice]];
    [cell.lblPrice setText:[NSString stringWithFormat:@"%0.2f",currProductPrice.fPrice]];
   
    [cell.lblCategory setText:[NSString stringWithFormat:@"%lu",currProductPrice.tCategory]];
    
    /*
    if(m_currProductPrice!=nil && m_currProductPrice==currProductPrice){
             cell.txtPrice.hidden=NO;
    }else{
            cell.txtPrice.hidden=YES;
    }
    */
    cell.txtPrice.hidden=!(m_currProductPrice!=nil && m_currProductPrice==currProductPrice);
    cell.lblPrice.hidden=!cell.txtPrice.hidden;
    cell.btnPrice.hidden=cell.txtPrice.hidden;
   
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    

    m_currProductPrice=nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Set the current product price
    m_currProductPrice=[arrShopProductPrices objectAtIndex:indexPath.row];
    
    //Update button status
    [self toggleButtons];
  
    [self.tbvShopProductPrices reloadData];

    
     NSLog(@"Row (%ld)", (long)indexPath.row);
    
}

//end: Methods to implement for fulfill CollectionView Interface

-(void) refreshShopProductPrices{
    
     m_currProductPrice=nil;
    
    //Request to Core manager for prices of current shop
    arrShopProductPrices=[CCoreManager getShopPriceList];
    
    //Refresh whole table
    [self.tbvShopProductPrices reloadData];
    
    //Update button status
    [self toggleButtons];
    
    if([arrShopProductPrices count]==0 && !self.btnAdd.enabled){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                    message:NSLocalizedString(@"NO_PRODUCTS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
        
        [mes show];
        
    }
    else{
        if(!self.btnAdd.enabled){
            UIAlertView* mes=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ATTENTION",nil)
                                                        message:NSLocalizedString(@"ALL_PRODUCTS",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles: nil];
            
            [mes show];
        }
    }
    
}


// Return an instance of this class, in that way the ViewController can access to this class
+(ShopListPricesVC *) sharedShopListPricesVC{
    return sharedInstance;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromDeleteShop"]){
        
        //Remove current shop
        [CCoreManager deleteShop];
        
        //Refresh shop list view
        [[ShopsListVC sharedViewController] refreshShopList];

    }
    
}

+(void) setNewProductShopPrice:(NSString*)p_sPrice{
    
    if(m_currProductPrice!=nil){
        
        //Look out only "." is accecpted as decimal in db, not "," comma
        NSString *sPrice =p_sPrice;
        sPrice = [sPrice stringByReplacingOccurrencesOfString:@","
                                                   withString:@"."];
        m_currProductPrice.fPrice= [sPrice floatValue];
        
        [CCoreManager updateProductPrice:m_currProductPrice];
    }
    
}

- (IBAction)btnDeleteProductPrice:(id)sender {
  
    if(m_currProductPrice!=nil){
        
        //Remove current shop
        [CCoreManager deleteProductPrice:m_currProductPrice];
        
        //Refresh shop list view
        m_currProductPrice=nil;
        
        //Request to Core manager for prices of current shop
        arrShopProductPrices=[CCoreManager getShopPriceList];
        
        //Refresh whole table
        [self.tbvShopProductPrices reloadData];
        
        //Update button status
        [self toggleButtons];

    }
 
    
}

-(void) toggleButtons{
    
    self.btnDel.enabled=(m_currProductPrice!=nil);
    self.btnAdd.enabled=!self.btnDel.enabled && ([CCoreManager getNumberShopNotExistingProducts]!=0);;
    self.btnDelShop.enabled=!self.btnDel.enabled;
    self.btnEditShop.enabled=!self.btnDel.enabled;
    
    

}

@end

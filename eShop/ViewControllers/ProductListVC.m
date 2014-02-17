//
//  ProductListVC.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ProductListVC.h"
//#import "AppDelegate.h"
#import "ProductViewCell.h"
#import "CProduct.h"
#import "CCoreManager.h"

static ProductListVC *sharedInstance;

@interface ProductListVC ()

@end

@implementation ProductListVC

@synthesize arrProducts;
@synthesize tbvProducts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


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
+(ProductListVC *) sharedViewController{
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvProducts setDataSource:self];
    [self.tbvProducts setDelegate:self];
    
    
    //Request to AppDelegate list of avaliable shops
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrProducts = [CCoreManager getProductsList];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.tbvProducts.backgroundColor = background;
    
    
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
    return [arrProducts count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"CellProductId";
    
    
    ProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ProductViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CProduct *currProduct = [arrProducts objectAtIndex:indexPath.row];
    
    [cell.lblName setText:[NSString stringWithFormat:@"%@",currProduct.sName]];
    
    if([currProduct.dPicture length]>0){
        cell.imgProd.image= [UIImage imageWithData:currProduct.dPicture ];
    }
    else{
        cell.imgProd.image= [UIImage imageNamed:@"NoPict"];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CProduct* cCurrProduct;
    
    // Get the current shop
    cCurrProduct = [arrProducts objectAtIndex:indexPath.row];
    
    //Notify CoreManager which is the active shop
    [CCoreManager setActiveProduct:cCurrProduct];
    
    [self performSegueWithIdentifier:@"showPriceShops2" sender:self.view];
    
  
}

//end: Methods to implement for fulfill CollectionView Interface


-(void) refreshProductList{
    //Request to Core manager for prices of current shop
   // AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrProducts = [CCoreManager getProductsList];
    
    //Refresh whole table
    [self.tbvProducts reloadData];
}


@end

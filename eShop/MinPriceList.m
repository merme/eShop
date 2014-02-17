//
//  SecondViewController.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "MinPriceList.h"
#import "MinPriceCell.h"
#import "CProductPrice.h"
#import "CCoreManager.h"

@interface MinPriceList ()

@end


@implementation MinPriceList

@synthesize tbvMinPrices;
@synthesize arrMinPrices;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // This class implements DataSource and Delegate callbacks
    [self.tbvMinPrices setDataSource:self];
    [self.tbvMinPrices setDelegate:self];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"common_bgt.png"]];
    self.tbvMinPrices.backgroundColor = background;
    
    //Set tittle text
    [self.barTop setTitle:NSLocalizedString(@"MIN_PROD_LIST", nil)];
    
    
    //Request to AppDelegate list of avaliable shops
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    arrMinPrices = [CCoreManager getProductsMinList];
    
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
    return [arrMinPrices count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"CellMinPriceId";
    
    
    MinPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MinPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CProductPrice *currProductPrice = [arrMinPrices objectAtIndex:indexPath.row];
    
    [cell.lblProductName setText:[NSString stringWithFormat:@"%@ (%@)",currProductPrice.sName,currProductPrice.sId]];
    [cell.lblShopName setText:[NSString stringWithFormat:@"%@ (%@)",currProductPrice.sShopName,currProductPrice.sShopId]];
    [cell.lblPrice setText:[NSString stringWithFormat:@"%0.2f",currProductPrice.fPrice]];
    
    if([currProductPrice.dPicture length]>0){
        cell.imgProd.image= [UIImage imageWithData:currProductPrice.dPicture ];
    }
    else{
        cell.imgProd.image= [UIImage imageNamed:@"NoPict"];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
}
// END: Methods to implement for fulfill CollectionView Interface

@end

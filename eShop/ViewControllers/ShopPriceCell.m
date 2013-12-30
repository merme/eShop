//
//  ShopPriceCell.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ShopPriceCell.h"
#import "ShopListPricesVC.h"

@implementation ShopPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}


- (IBAction)didEndOnExit:(id)sender {

    [sender resignFirstResponder];
}

- (IBAction)editngDidEnd:(id)sender {

 //   [ShopListPricesVC setNewProductShopPrice:self.txtPrice.text];
    [sender resignFirstResponder];
}

- (IBAction)touchUpOutside:(id)sender {
    [sender resignFirstResponder];

}
- (IBAction)btnConfirmPrice:(id)sender {
    [ShopListPricesVC setNewProductShopPrice:self.txtPrice.text];
    [[ShopListPricesVC sharedShopListPricesVC] refreshShopProductPrices];
    [sender resignFirstResponder];
}





@end

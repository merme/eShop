//
//  CShop.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CShop : NSObject <NSCoding>

@property NSString *sId;
@property (strong,nonatomic) NSString *sName;
@property (strong,nonatomic) NSString *sLocation;


-(id)initWithName:(NSString*)p_strName;

@end

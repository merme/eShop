//
//  CShop.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/12/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CShop.h"

@implementation CShop

@synthesize sName;

-(id)initWithName:(NSString*)p_strName
{
    if (self = [super init])
    {
        // Initialization code here
        self.sName=p_strName;
    }
    return self;
}



/* NSCoding interface methods:Begin */

-(id)initWithCoder:(NSCoder *)decoder  {
    if (self = [super init]) {
        self.sName =[ decoder decodeObjectForKey:@"Name"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.sName forKey:@"Name"];

}
/* NSCoding interface methods:End */

@end

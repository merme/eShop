//
//  CRemoteDatabase.h
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 22/02/14.
//  Copyright (c) 2014 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRemoteDatabase : NSObject<NSURLSessionDelegate>

+(void) dumpDDBB;
- (NSString *)encodeToBase64String:(UIImage *)image;

@end

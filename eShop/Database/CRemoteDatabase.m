//
//  CRemoteDatabase.m
//  eShop
//
//  Created by JAVIER CALATRAVA LLAVERIA on 22/02/14.
//  Copyright (c) 2014 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "CRemoteDatabase.h"
#import "CDatabase.h"

#define SERVER @"http://bigsur11.synology.me:321/insertProduct.php"


@implementation CRemoteDatabase

NSMutableData *responseData;
NSURLConnection *connection;

+(void) dumpDDBB{
    
    NSMutableArray *arrPructs = [CDatabase getProductsList];
    
    CProduct *currProduct = [arrPructs  objectAtIndex:0];
    
    if(currProduct!=nil){
        currProduct.sId=@"005";
        currProduct.sName=@"Olivas";
        
        /*
        NSString *post = @"PRODUCT_ID=005&PRODUCT_NAME=Detergente";
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://bigsur11.synology.me:321/insertProduct.php"]];
        [request setHTTPMethod:@"POST"];
        [request setTimeoutInterval:30.0f];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];

        
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        //NSURL *url = [NSURL URLWithString:@"http://url_to_manage_post_requests"];
        //request = [NSMutableURLRequest requestWithURL:url];
        //request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
        //request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // The server answers with an error because it doesn't receive the params
            if([data length]>0 && error==nil){
                NSString *html=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"HTML=%@",html);
            }
            else if([data length]==0 && error==nil){
                NSLog(@"Nothing was downloaded");
            }
            else if(error!=nil){
                NSLog(@"Error happened =%@",error);
            }
        }];
        [postDataTask resume];
        
        */

        
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            
            NSURL * url = [NSURL URLWithString:@"http://bigsur11.synology.me:321/insertProduct.php"];
                           //@"http://hayageek.com/examples/jquery/ajax-post/ajax-post.php"];
            NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
            NSString * params =[[NSString alloc] initWithFormat:@"PRODUCT_ID=%@PRODUCT_NAME=%@",currProduct.sId,currProduct.sName];//@"name=Ravi&loc=India&age=31&submit=true";
            if(currProduct.dPicture!=nil){
                [params stringByAppendingFormat:@"PICTURE=%@",[currProduct.dPicture base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
                params =[[NSString alloc] initWithFormat:@"PRODUCT_ID=%@&PRODUCT_NAME=%@&PICTURE=%@",currProduct.sId,currProduct.sName,[currProduct.dPicture base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
                
                //NSLog(@"%@",[currProduct.dPicture base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]);
            }
            else{
                params =[[NSString alloc] initWithFormat:@"PRODUCT_ID=%@&PRODUCT_NAME=%@&PICTURE=",currProduct.sId,currProduct.sName];
                
            }
        //NSLog(@"%@[%d]",params,[params length]);

            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                   NSLog(@"Response:%@ %@\n", response, error);
                                                                   if(error == nil)
                                                                   {
                                                                       NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                                       NSLog(@"Data = %@",text);
                                                                   }
                                                                   
                                                               }];
            [dataTask resume];
        
        /*
        // Create url connection and fire request
        //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        
        [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSDefaultRunLoopMode];
        [connection start];

        */
        
    }
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler 1");
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",str);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}


- (NSString *)encodeToBase64String:(UIImage *)image {

    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end

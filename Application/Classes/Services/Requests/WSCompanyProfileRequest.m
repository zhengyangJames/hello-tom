//
//  WSCompanyProfileRequest.m
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSCompanyProfileRequest.h"

@implementation WSCompanyProfileRequest

- (WSCompanyProfileRequest *)postCompanyProfile:(NSDictionary *)companyDic imageView:(UIImageView *)imageView  {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSData *httpBody = [self createBodyWithBoundary:boundary parameters:companyDic image:imageView fileName:[NSString stringWithFormat:@"%@_logo.png",[[NSUUID UUID] UUIDString]]];
    [request setHTTPBody:httpBody];

    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"content-type"];
    
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_COMPANY_PROFILE]];
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [request setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    return request;
}

- (WSCompanyProfileRequest *)getCompanyProfile {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [request setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    [request setURL:[NSURL URLWithString:WS_METHOD_COMPANY_PROFILE]];
    return request;
}

- (NSData *)createBodyWithBoundary:(NSString *)boundary parameters:(NSDictionary *)parameters image:(UIImageView *)image fileName:(NSString *)fileName {
    NSMutableData *httpBody = [NSMutableData data];
    // add params (all params are strings)
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
    // add image data
    if (image) {
        NSData *imageData = UIImagePNGRepresentation(image.image);
        
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n", @"logo",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:imageData];
        [httpBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}

@end

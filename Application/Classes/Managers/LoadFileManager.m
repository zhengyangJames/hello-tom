//
//  LoadFileManager.m
//  CoAssest
//
//  Created by TUONG DANG on 6/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "LoadFileManager.h"

@implementation LoadFileManager

+ (NSArray*)loadFileJsonWithName:(NSString*)fileName {
    NSError  * error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *arrayObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    return arrayObj;
}

+ (NSArray*)loadFilePlistWithName:(NSString*)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return array;
}

+ (void)writeFilePlistWithName:(NSArray*)array fileName:(NSString*)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    [array writeToFile:path atomically:YES];
}

+ (NSString *)getDocsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end
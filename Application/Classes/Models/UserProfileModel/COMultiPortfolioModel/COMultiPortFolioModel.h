//
//  COMultiPortpolioModel.h
//  CoAssets
//
//  Created by Macintosh HD on 1/20/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COMultiPortfolioModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSDictionary  *ongoingInvestment;
@property (nonatomic, strong) NSDictionary  *completeInvestment;
@property (nonatomic, strong) NSNumber  *ongoingProject;
@property (nonatomic, strong) NSNumber  *completeProject;


- (NSNumber *)numberOfOngoingProject;
- (NSNumber *)numberOfCompleteProject;
- (NSDictionary *)dictionOngoingInvestment;
- (NSDictionary *)dictionCompleteInvestment;
- (NSString*)OngoingProjectsImage;
- (NSString*)COOngoingInvestmentImage;
- (NSString*)COCompletedProjectsImage;
- (NSString*)COCompletedInvestmentImage;

- (NSString*)OngoingProjectsTitle;
- (NSString*)COOngoingInvestmentTitle;
- (NSString*)COCompletedProjectsTitle;
- (NSString*)COCompletedInvestmentTitle;
@end

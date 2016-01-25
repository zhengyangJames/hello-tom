//
//  COMultiPortpolioModel.m
//  CoAssets
//
//  Created by Macintosh HD on 1/20/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COMultiPortFolioModel.h"

@implementation COMultiPortFolioModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"ongoingInvestment"       : @"ongoing_investment",
        @"completeInvestment"       : @"funded_and_completed_investment",
        @"ongoingProject"       : @"ongoing_projects",
        @"completeProject"       : @"funded_and_completed_projects",
        
    };
}

- (NSNumber *)numberOfOngoingProject {
    return self.ongoingProject;
}

- (NSNumber *)numberOfCompleteProject {
    return self.completeProject;
}

- (NSDictionary *)dictionOngoingInvestment {
    return self.ongoingInvestment;
}

- (NSDictionary *)dictionCompleteInvestment {
    return self.completeInvestment;
}

- (NSString*)OngoingProjectsImage {
    return @"ic_loadding";
}

- (NSString*)COOngoingInvestmentImage {
    return @"ic_money";
}

- (NSString*)COCompletedProjectsImage {
    return @"ic_homes";
}

- (NSString*)COCompletedInvestmentImage {
    return @"ic_Check_red";
}

- (NSString*)OngoingProjectsTitle {
    return @"Ongoing Projects";
}
- (NSString*)COOngoingInvestmentTitle {
    return @"Ongoing Investment Amount";
}
- (NSString*)COCompletedProjectsTitle {
    return @"Funded & Completed Projects";
}
- (NSString*)COCompletedInvestmentTitle {
    return @"Funded & Completed Investment Amount";
}

@end

//
//  NProfileHeaderView.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

@protocol NProfileHeaderViewDelegate;

@interface NProfileHeaderView : BaseView

@property (nonatomic, weak) id<NProfileHeaderViewDelegate>delegate;

@end


@protocol NProfileHeaderViewDelegate <NSObject>

@required
- (void)nprofileHeaderView:(NProfileHeaderView *)profileHeader didSelectindex:(NSInteger)index;

@end
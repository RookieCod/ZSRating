//
//  WMRatingControl.h
//  womaiw
//
//  Created by Zhangsong on 15-8-20.
//  Copyright (c) 2015年 中粮我买网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSRatingControl;
@protocol ZSRatingControlDelegate <NSObject>

- (void)ratingControl:(ZSRatingControl *)ratingControl didSelectedRating:(NSInteger)selectedRating;
@end

@interface ZSRatingControl : UIControl

@property (nonatomic, assign) NSInteger rating;//当前评分

@property (nonatomic, assign) id<ZSRatingControlDelegate> delegate;
- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating;
@end

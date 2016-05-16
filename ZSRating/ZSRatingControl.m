//
//  WMRatingControl.m
//  womaiw
//
//  Created by Zhangsong on 15-8-20.
//  Copyright (c) 2015年 中粮我买网. All rights reserved.
//

#import "ZSRatingControl.h"

static const NSInteger kStarWidthAndHeight = 27;

@interface ZSRatingControl ()
{
    NSInteger _maxRating;
    UIImage *_emptyImage;
    UIImage *_solidImage;
}
@end

@implementation ZSRatingControl

//重写属性的setter方法
- (void)setRating:(NSInteger)rating
{
    _rating = (rating < 0) ? 0 : rating;
    _rating = (rating > _maxRating) ? _maxRating : _rating;
    
    [self setNeedsDisplay];
}

- (id)initWithLocation:(CGPoint)location andMaxRating:(NSInteger)maxRating
{
    if (self = [super initWithFrame:CGRectMake(location.x, location.y, (maxRating * kStarWidthAndHeight), kStarWidthAndHeight)]) {
        
        self.backgroundColor = [UIColor clearColor];
        _rating = 0;
        _emptyImage = [UIImage imageNamed:@"rating_grayStar"];//默认星星图案，可以换成想要的图片
        _solidImage = [UIImage imageNamed:@"rating_orangeStar"];
        _maxRating = maxRating;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGPoint currPoint = CGPointMake(0, (kStarWidthAndHeight - 20)/2);
    
    for (int i = 0; i < _rating; i++)
    {
        if (_solidImage)
        {
            [_solidImage drawAtPoint:currPoint];
        }
        currPoint.x += kStarWidthAndHeight;
    }
    
    NSInteger remaining = _maxRating - _rating;
    
    for (int i = 0; i < remaining; i++)
    {
        if (_emptyImage)
        {
            [_emptyImage drawAtPoint:currPoint];
        }
        currPoint.x += kStarWidthAndHeight;
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self handleTouch:touch];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self handleTouch:touch];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //这个方法在使用addTarge:action:的时候必须实现，作用是告诉controller去实现action，现在用代理不需要实现此方法
    //[self sendActionsForControlEvents:UIControlEventEditingDidEnd];
    if([self.delegate respondsToSelector:@selector(ratingControl:didSelectedRating:)]){
        
        [self.delegate ratingControl:self didSelectedRating:self.rating];
    }
}

- (void)handleTouch:(UITouch *)touch
{
    CGFloat width = self.frame.size.width;
    CGRect section = CGRectMake(0, 0, (width / _maxRating), self.frame.size.height);
    
    CGPoint touchLocation = [touch locationInView:self];
    
    if (touchLocation.x < 0)
    {
        if (_rating != 0)
        {
            _rating = 1;
            //[self sendActionsForControlEvents:UIControlEventEditingChanged];
        }
    }
    else if (touchLocation.x > width)
    {
        if (_rating != _maxRating)
        {
            _rating = _maxRating;
            //[self sendActionsForControlEvents:UIControlEventEditingChanged];
        }
    }
    else
    {
        for (int i = 0 ; i < _maxRating ; i++)
        {
            if ((touchLocation.x > section.origin.x) && (touchLocation.x < (section.origin.x + section.size.width)))
            {
                if (_rating != (i+1))
                {
                    _rating = i+1;
                    //[self sendActionsForControlEvents:UIControlEventEditingChanged];
                }
                break;
            }
            section.origin.x += section.size.width;
        }
    }
    [self setNeedsDisplay];
}

@end

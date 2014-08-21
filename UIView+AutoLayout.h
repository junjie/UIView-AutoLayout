//
//  UIView+AutoLayout.h
//
//  Created by Lin Junjie on 20/8/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/**
 Must call after subview is added to self
 */
- (void)addConstraintsFittingSubviewToSelf:(UIView *)subview;
- (void)addConstraintsCenteringSubviewInSelf:(UIView *)subview;
- (void)addConstraintsSizingSubview:(UIView *)subview toWidth:(CGFloat)width height:(CGFloat)height;

@end

@interface NSLayoutConstraint (AutoLayout)

+ (NSArray *)constraintsFittingSubviewToSuperview:(UIView *)subview;
+ (NSArray *)constraintsCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview;
+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height forSubview:(UIView *)subview;

@end
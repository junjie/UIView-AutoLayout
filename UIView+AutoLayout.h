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
- (void)addConstraintsSizingSubview:(UIView *)subview toWidth:(CGFloat)width height:(CGFloat)height withMinimumInsetsFromSelf:(UIEdgeInsets)insets;
@end

@interface NSLayoutConstraint (AutoLayout)

+ (NSArray *)constraintsFittingSubviewToSuperview:(UIView *)subview;

+ (NSArray *)constraintsCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview;
+ (NSLayoutConstraint *)constraintVerticallyCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview;
+ (NSLayoutConstraint *)constraintHorizontallyCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview;

+ (NSArray *)constraintsOfWidth:(CGFloat)width forSubview:(UIView *)subview;
+ (NSArray *)constraintsOfHeight:(CGFloat)height forSubview:(UIView *)subview;
+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height forSubview:(UIView *)subview;
+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height minimumInsetsFromSuperview:(UIEdgeInsets)insets forSubview:(UIView *)subview;

+ (NSLayoutConstraint *)constraintAligningSubview:(UIView *)subview toSuperview:(UIView *)superview attribute:(NSLayoutAttribute)attribute padding:(CGFloat)padding;

@end

//
//  UIView+AutoLayout.m
//
//  Created by Lin Junjie on 20/8/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)addConstraintsFittingSubviewToSelf:(UIView *)subview
{
	NSArray *constraints = [NSLayoutConstraint constraintsFittingSubviewToSuperview:subview];
	
	if (constraints)
	{
		[subview setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addConstraints:constraints];
	}
	else
	{
		NSAssert(0, @"Can't obtain constraints to fit subview (%@) to self", subview);
	}
}

- (void)addConstraintsCenteringSubviewInSelf:(UIView *)subview
{
	NSArray *constraints = [NSLayoutConstraint constraintsCenteringSubview:subview inSuperview:self];
	
	if (constraints)
	{
		[subview setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addConstraints:constraints];
	}
	else
	{
		NSAssert(0, @"Can't obtain constraints to center subview (%@) in self", subview);
	}
}

- (void)addConstraintsSizingSubview:(UIView *)subview toWidth:(CGFloat)width height:(CGFloat)height
{
	NSArray *constraints = [NSLayoutConstraint constraintsOfWidth:width height:height forSubview:subview];
	
	if (constraints)
	{
		[subview setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addConstraints:constraints];
	}
	else
	{
		NSAssert(0, @"Can't obtain constraints to size subview (%@) to %.2f x %.2f", subview, width, height);
	}
}

@end

@implementation NSLayoutConstraint (AutoLayout)

+ (NSArray *)constraintsFittingSubviewToSuperview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:2];
	
	NSDictionary *bindings = NSDictionaryOfVariableBindings(subview);
	
	NSArray *constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
											options:0
											metrics:nil
											  views:bindings];
	
	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
											options:0
											metrics:nil
											  views:bindings];
	
	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	return [allConstraints copy];;
}

+ (NSArray *)constraintsCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview
{
	NSLayoutConstraint *constraintX =
	[NSLayoutConstraint constraintWithItem:subview
								 attribute:NSLayoutAttributeCenterX
								 relatedBy:NSLayoutRelationEqual
									toItem:superview
								 attribute:NSLayoutAttributeCenterX
								multiplier:1
								  constant:0];
	
	NSLayoutConstraint *constraintY =
	[NSLayoutConstraint constraintWithItem:subview
								 attribute:NSLayoutAttributeCenterY
								 relatedBy:NSLayoutRelationEqual
									toItem:superview
								 attribute:NSLayoutAttributeCenterY
								multiplier:1
								  constant:0];

	if (constraintX && constraintY)
	{
		return @[constraintX, constraintY];
	}
	
	return nil;
}

+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height forSubview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:2];
	
	NSDictionary *bindings = NSDictionaryOfVariableBindings(subview);
	NSDictionary *metrics = @{@"width" : @(width), @"height" : @(height)};
	
	NSArray *constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview(height)]"
											options:0
											metrics:metrics
											  views:bindings];
	
	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview(width)]"
											options:0
											metrics:metrics
											  views:bindings];
	

	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	return [allConstraints copy];
}

@end
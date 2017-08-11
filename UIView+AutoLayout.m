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

- (void)addConstraintsSizingSubview:(UIView *)subview toWidth:(CGFloat)width height:(CGFloat)height withMinimumInsetsFromSelf:(UIEdgeInsets)insets
{
	NSArray *constraints = [NSLayoutConstraint constraintsOfWidth:width height:height minimumInsetsFromSuperview:insets forSubview:subview];
	
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
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:4];
	
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

+ (NSLayoutConstraint *)constraintVerticallyCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview
{
	return [NSLayoutConstraint constraintWithItem:subview
										attribute:NSLayoutAttributeCenterY
										relatedBy:NSLayoutRelationEqual
										   toItem:superview
										attribute:NSLayoutAttributeCenterY
									   multiplier:1
										 constant:0];
}

+ (NSLayoutConstraint *)constraintHorizontallyCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview
{
	return [NSLayoutConstraint constraintWithItem:subview
										attribute:NSLayoutAttributeCenterX
										relatedBy:NSLayoutRelationEqual
										   toItem:superview
										attribute:NSLayoutAttributeCenterX
									   multiplier:1
										 constant:0];
}

+ (NSArray *)constraintsCenteringSubview:(UIView *)subview inSuperview:(UIView *)superview
{
	NSLayoutConstraint *constraintX = [self constraintHorizontallyCenteringSubview:subview inSuperview:superview];
	NSLayoutConstraint *constraintY = [self constraintVerticallyCenteringSubview:subview inSuperview:superview];

	if (constraintX && constraintY)
	{
		return @[constraintX, constraintY];
	}
	
	return nil;
}

+ (NSLayoutConstraint *)constraintAligningSubview:(UIView *)subview toSuperview:(UIView *)superview attribute:(NSLayoutAttribute)attribute padding:(CGFloat)padding
{
	return [NSLayoutConstraint constraintWithItem:subview
										attribute:attribute
										relatedBy:NSLayoutRelationEqual
										   toItem:superview
										attribute:attribute
									   multiplier:1
										 constant:padding];
}

+ (NSArray *)constraintsOfWidth:(CGFloat)width forSubview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:4];
	
	NSDictionary *bindings = NSDictionaryOfVariableBindings(subview);
	NSDictionary *metrics = @{@"width" : @(width)};
	
	NSArray *constraints =
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

+ (NSArray *)constraintsOfHeight:(CGFloat)height forSubview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:4];
	
	NSDictionary *bindings = NSDictionaryOfVariableBindings(subview);
	NSDictionary *metrics = @{@"height" : @(height)};
	
	NSArray *constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview(height)]"
											options:0
											metrics:metrics
											  views:bindings];
	
	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	return [allConstraints copy];
}

+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height forSubview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:4];
	
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

+ (NSArray *)constraintsOfWidth:(CGFloat)width height:(CGFloat)height minimumInsetsFromSuperview:(UIEdgeInsets)insets forSubview:(UIView *)subview
{
	NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:6];
	
	NSDictionary *bindings = NSDictionaryOfVariableBindings(subview);
	NSDictionary *metrics = @{@"width" : @(width),
							  @"height" : @(height),
							  @"top" : @(insets.top),
							  @"bottom" : @(insets.bottom),
							  @"left" : @(insets.left),
							  @"right" : @(insets.right)
							  };
	
	NSArray *constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=top@1000)-[subview(height@750)]-(>=bottom@1000)-|"
											options:0
											metrics:metrics
											  views:bindings];
	
	if ([constraints count])
	{
		[allConstraints addObjectsFromArray:constraints];
	}
	
	constraints =
	[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=left@1000)-[subview(width@750)]-(>=right@1000)-|"
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

//
//  RotateView.h
//  Effector
//
//  Created by TOKUBO KOJI on 10/07/04.
//  Copyright 2010 Storytellers, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>
#import "RotateView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "MainViewController.h"
//#import "Corninator.h";

static inline CGFloat angleBetweenLinesInRadians(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
	
	CGFloat a = line1End.x - line1Start.x;
	CGFloat b = line1End.y - line1Start.y;
	CGFloat c = line2End.x - line2Start.x;	CGFloat d = line2End.y - line2Start.y;
    

    CGFloat line1Slope = (line1End.y - line1Start.y) / (line1End.x - line1Start.x);
    CGFloat line2Slope = (line2End.y - line2Start.y) / (line2End.x - line2Start.x);
	CGFloat degs = acosf(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
	
	return (line2Slope > line1Slope) ? degs : -degs;	
}


static inline CGFloat sizeRatio(CGPoint firstprev, CGPoint secoundprev, CGPoint firstcurrent, CGPoint secoundcurrent) {
	
	CGFloat distanceprev =sqrt( pow( firstprev.x - secoundprev.x ,2.0) + pow(firstprev.y  -secoundprev.y, 2.0) );
	CGFloat distancecurrent =sqrt( pow( firstcurrent.x - secoundcurrent.x ,2.0) + pow(firstcurrent.y  -secoundcurrent.y, 2.0) );
    
	CGFloat ratio = distancecurrent /distanceprev;
	return ratio;
}




@interface RotateView : UIView {
	UILabel *label;
	MainViewController *rootViewController;
	UIImageView *meganeimageVIew;
	 UIImage *meganeImage;
//	Corninator *cordinator;

}
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) 	MainViewController *rootViewController;
@property (readwrite, retain) IBOutlet 	UIImageView *meganeimageVIew;
@property (readwrite, retain) UIImage *meganeImage;
//@property (nonatomic) 	Corninator *cordinator;

- (void)setmeganeImage;

@end

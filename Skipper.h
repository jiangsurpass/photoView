//
//  Skipper.h
//  SV
//
//  Created by TOKUBO KOJI on 10/06/05.
//  Copyright 2010 Storytellers, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RotateView.h"
@interface Skipper : UIView {
	RotateView *rotateView;
	UIImage *navimg;
	int pointingPage;
	int pointingx;
	int barlength;
	int barmargin,pagenum,margin,innermargin,width,barpadding,bottommargin;
	float blocksize;
}

@property(nonatomic) int currentx;
@property(nonatomic) int pointingPage;
@property(nonatomic) int pointingx;
@property(nonatomic) int barlength;
@property(nonatomic) int barmargin;
@property(nonatomic) int pagenum;
@property(nonatomic) int margin;
@property(nonatomic) int innermargin;
@property(nonatomic) int barpadding;
@property(nonatomic) int bottommargin;
@property(nonatomic) int width;
@property(nonatomic) float blocksize;
@property(nonatomic,retain) RotateView *rotateView;
@property(assign,readwrite) UIImage *navimg;

- (void)initNumbers;
- (void)setNavigations;

@end

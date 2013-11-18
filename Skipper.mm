//
//  Skipper.m
//  SV
//
//  Created by TOKUBO KOJI on 10/06/05.
//  Copyright 2010 Storytellers, Inc. All rights reserved.
//

#import "Skipper.h"
#import "RotateView.h"

@implementation Skipper
@synthesize rotateView;
@synthesize navimg,pointingPage,pointingx,barlength,barmargin,pagenum,margin,innermargin,width,bottommargin;
@synthesize blocksize;

- (BOOL) amIAnIPad {
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
	if ([[UIDevice currentDevice] respondsToSelector: @selector(userInterfaceIdiom)])
		return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
#endif
    return NO;
}

- (void)initNumbers{
//	pointingPage = self.rootViewController.position;
	margin=14;
	innermargin=margin;
	pagenum = 51;
	width = 320;
	if ([ self amIAnIPad ]){
		width =768;
	}
	int blocklength = ( width - innermargin*2 - margin*2);
	blocksize = ((float)blocklength  / ( (float)pagenum + 2.0 )) ;
	NSLog(@"blocksizeis %f",blocksize);
//	blocksize = (7);
	//barpadding = margin*2 + innermargin*2 + blocksize*2;
	barmargin = margin+blocksize+innermargin;
	barlength = width - barmargin * 2;
	bottommargin = 6;
    
}
- (void)setNavigations{
	UIImage *leftallowImage = [UIImage imageNamed:@"home.png"];
	UIImageView *leftallowImageView = [[UIImageView alloc] initWithImage:leftallowImage];
	leftallowImageView.frame = CGRectMake(margin-4, bottommargin-2, blocksize * 2, blocksize * 2);
	UIImage *rightallowImage = [UIImage imageNamed:@"camera.png"];
	UIImageView *rightallowImageView = [[UIImageView alloc] initWithImage:rightallowImage];
	rightallowImageView.frame = CGRectMake(width -  margin - blocksize*2 + 4, bottommargin-2, blocksize * 2, blocksize * 2);
	
	UIButton *leftButton = [ [ UIButton alloc] initWithFrame:CGRectMake(0, 0, barmargin+7, 40)];
	[ leftButton setBackgroundColor:[UIColor clearColor]];
	[ leftButton addTarget:self action:@selector(leftTapped:) forControlEvents:UIControlEventTouchUpInside];
	[ self addSubview:leftButton];
							
	UIButton *rightButton = [ [ UIButton alloc] initWithFrame:CGRectMake( width - barmargin-7,0, barmargin+7, 40)];
	[ rightButton setBackgroundColor:[UIColor clearColor]];
	[ rightButton addTarget:self action:@selector(rightTapped:) forControlEvents:UIControlEventTouchUpInside];
	[ self addSubview:rightButton];
	

	[ self addSubview:leftallowImageView];
	[ self addSubview:rightallowImageView];
	[ leftallowImage release ];
	[ rightallowImage release];
	[rightallowImageView release];
	[leftallowImageView release];
	[leftButton release];
	[rightButton release];
	
	
	
}

- (void)drawRect:(CGRect)rect{
	//	[super drawRect:rect ];
	if(pointingx ==0){
		pointingx = barmargin;
	}		
	
	UIColor *bgcolor = [UIColor whiteColor];
	[ bgcolor setFill];
	UIRectFill(CGRectMake(barmargin,bottommargin+2,barlength,blocksize));
	
	UIColor *pointerColor = [UIColor colorWithRed:0.0 green:0.81 blue:1.0 alpha:1.0];
	[ pointerColor setFill];
	UIRectFill(CGRectMake(barmargin + pointingPage * blocksize,bottommargin+2,blocksize,blocksize));

}

- (IBAction)leftTapped:(UIButton*)sender {
	NSLog(@"leftTapped");
	if( self.pointingPage > 0 ){
		self.pointingPage = self.pointingPage -1;
		[ self changeImage ];
		[ self setNeedsDisplay ];
	}
		
	
}
- (IBAction)rightTapped:(UIButton*)sender {
	NSLog(@"rightTapped");
	if(pointingPage < pagenum-1){
		
		self.pointingPage++;
		[ self changeImage ];
		[ self setNeedsDisplay ];
	}	
}


/*
 - (void) initWithFrame:(CGRect)frame{
	[super initWithFrame:frame];
		

		navimg = [ UIImage imageNamed:@"EF_navi.png"];
		UIImageView *navimgview = [[UIImageView alloc] initWithImage:navimg];
		navimgview.frame = CGRectMake(5, 10, 20, 20);
		[ self addSubview:navimgview];
 

 } 
*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *atouch = [ touches anyObject ];
	CGPoint locationPoint = [ atouch locationInView: atouch.window  ];
	if(locationPoint.x > barmargin && locationPoint.x < width-barmargin-blocksize){
		self.pointingx = locationPoint.x;
	}
}


- (void)changeImage{
	NSLog(@"changing image");

	int mode = 0;
	int filepage = pointingPage;
	if(pointingPage > 26){
		NSLog(@"mode1");
		mode = 1;
		filepage = pointingPage - 27;
	}
	
	NSString *filename = 	[ NSString stringWithFormat:@"%d_%d",mode, filepage];
//	[ self.rotateView.cordinator setLabel:filename];
	NSString *path = [ NSString stringWithFormat:@"%@.png",filename] ;
	NSLog(path);
	NSLog(@"hoge");
	
	self.rotateView.meganeImage = [UIImage imageNamed:path];
	self.rotateView.meganeimageVIew.image = self.rotateView.meganeImage;
	[ self setNeedsDisplay ];
	
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *atouch = [ touches anyObject ];
	CGPoint locationPoint = [ atouch locationInView: atouch.window  ];
	if(locationPoint.x > barmargin && locationPoint.x < width-barmargin-3){
		
//		self.pointingPage = ceil ( ( pagenum ) * (  ( locationPoint.x - ( barmargin * 2 ) )  / barlength) );
		self.pointingPage = floor(  ( locationPoint.x - barmargin )  / (float)blocksize ) ;
		self.pointingx = locationPoint.x;
		[self changeImage];
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}
@end
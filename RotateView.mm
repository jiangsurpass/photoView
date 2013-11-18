#import <QuartzCore/QuartzCore.h>
#import "RotateView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Skipper.h"
#import "MainViewController.h"

@implementation RotateView
@synthesize label;
@synthesize meganeimageVIew;
@synthesize rootViewController;
@synthesize meganeImage;
//@synthesize cordinator;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        
    }
    return self;
}
- (void)setmeganeImage{
    
	NSLog(@"set megane images is called ");
	UIImage *image = self.rootViewController.faceimg;
	NSLog(@"%f",image.size.width);
	NSLog(@"trying to get the ratio");
	int the_height_when_expanded = ( 320 / image.size.width ) * image.size.height ;
	int ratio = image.size.width*100 / image.size.height;
	NSLog(@"%d",ratio);
	CGRect 		frame = CGRectMake(-20, -4, 360, 484);
	NSLog(@"the size of image");
	NSLog(@"%d" ,ratio);
	NSLog(@"%d",(100*320/480)+10);
	NSLog(@"%d",(100*320/480)-10);
	NSLog(@"%d",( ratio < ((100*320/480)+10) && ratio > ((100*320/480)-10) ));
//	if( ( ratio < ((100*320/480)+10) && ratio > ((100*320/480)-10) ) || self.cordinator.rootViewController.sample == 1){
//		if(self.cordinator.rootViewController.sample == 1){
//			frame = CGRectMake(0, 0, 320, 480);
//		}
//		if(self.cordinator.rootViewController.sample == 2){
//			frame = CGRectMake(0, 0, 320, 480);
//		}
//		
////		frame = CGRectMake(0, 0, 320, 480);
//		NSLog(@"the 320 480 size will be used");
//		
//	}else{
//		NSLog(@"the customized size will be used");
//		frame = CGRectMake(0, ( 480 - the_height_when_expanded ) / 2 , 320, the_height_when_expanded);
//	}
	
	UIImageView *imageview = [[UIImageView alloc ] initWithFrame:frame];
	[ imageview setImage:image];
//	UIImageView *imageview = [[UIImageView alloc ] initWithImage:image];
	
//	imageview.frame = CGRectMake(-0, -0, 320, 480);
	[ self addSubview:imageview ];
	
	NSLog(@"printing hoge for set megane ");
	NSString *path = @"logo.png" ;
	meganeImage = [UIImage imageNamed:path ];
	meganeimageVIew = [[ UIImageView alloc ] initWithImage:meganeImage];
	meganeimageVIew.frame = CGRectMake(40, 165, 240, 76);
	[self addSubview:meganeimageVIew];
    CGRect screen = [[UIScreen mainScreen] bounds];
    
	Skipper *skipper = [[ Skipper alloc ]initWithFrame:CGRectMake(0, screen.size.height - 30,320,30)];
	[ skipper initNumbers ];
	[ skipper setNavigations ];	
//	if (self.cordinator.rootViewController.mode == 1) {
//		skipper.pointingPage = self.cordinator.rootViewController.position + 27; 
//	}else {
//		skipper.pointingPage = self.cordinator.rootViewController.position;
//	}

	skipper.rotateView		 = (RotateView *)self;
	[ self addSubview:skipper];
	[self setNeedsDisplay ];
	
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
	if ([touches count] == 2) {
        NSArray *twoTouches = [touches allObjects];
        UITouch *first = [twoTouches objectAtIndex:0];
        UITouch *second = [twoTouches objectAtIndex:1];
		
		CGFloat currentAngle = angleBetweenLinesInRadians([first previousLocationInView:self], [second previousLocationInView:self], [first locationInView:self], [second locationInView:self]);	
		CGFloat ratio = sizeRatio([first previousLocationInView:self], [second previousLocationInView:self], [first locationInView:self], [second locationInView:self]);
		meganeimageVIew.transform = CGAffineTransformRotate(meganeimageVIew.transform, currentAngle);
		meganeimageVIew.transform = CGAffineTransformScale(meganeimageVIew.transform, ratio, ratio);
		
	}else{
		//	}else  if([ touches count ] == 1 ) {
		NSLog(@"touch is one");
		UITouch *touch = [ [touches allObjects] objectAtIndex:0];
		CGFloat newx = ( meganeimageVIew.center.x + [ touch locationInView:self].x -[ touch previousLocationInView:self].x  );
		CGFloat newy = ( meganeimageVIew.center.y +  [ touch locationInView:self].y  - [ touch previousLocationInView:self].y);
		[meganeimageVIew setCenter:CGPointMake(newx, newy)];
		
	}
	
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touched once");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touch ends");
	
}

@end
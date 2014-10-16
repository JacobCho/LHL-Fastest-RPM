//
//  ViewController.m
//  Fastest RPM
//
//  Created by Jacob Cho on 2014-10-16.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGPoint startLocation;
    double startTime;
    double endTime;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needle.layer.anchorPoint = CGPointMake(self.needle.layer.anchorPoint.x-0.4, self.needle.layer.anchorPoint.y);
    
    
    [self moveNeedle:-11];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
    
}




-(void)panGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        startLocation = [sender locationInView:self.view];
        startTime = [[NSDate date] timeIntervalSince1970] * 100;
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint stopLocation = [sender locationInView:self.view];
        CGFloat dx = stopLocation.x - startLocation.x;
        CGFloat dy = stopLocation.y - startLocation.y;
        CGFloat distance = sqrt(dx*dx + dy*dy );
        endTime = [[NSDate date] timeIntervalSince1970] * 100;
        double time = endTime - startTime;
        float velocity = distance / (float)time;
        [self moveNeedle:velocity];
        NSLog(@"%f", velocity);

    }

}



-(void) moveNeedle:(float)angl
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0f];
    
    if (angl >= 20.5) angl = 20.5;
    if (angl < -11) angl = -11;
        

    [self.needle setTransform: CGAffineTransformMakeRotation((M_PI / 9) *angl)];
    
    [UIView commitAnimations];
}


@end

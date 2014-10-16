//
//  ViewController.m
//  Fastest RPM
//
//  Created by Jacob Cho on 2014-10-16.
//  Copyright (c) 2014 Jacob Cho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

    CGPoint startVelocity;
    CGPoint endVelocity;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needle.layer.anchorPoint = CGPointMake(self.needle.layer.anchorPoint.x-0.4, self.needle.layer.anchorPoint.y);
    
    
    [self moveNeedle:-220];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
    
}




-(void)panGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {

        startVelocity = [sender velocityInView:self.view];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        endVelocity = [sender velocityInView:self.view];
        CGFloat vx = endVelocity.x - startVelocity.x;
        CGFloat vy = endVelocity.y - startVelocity.y;
        CGFloat velocity = sqrt(vx*vx + vy*vy);
        
        [self moveNeedle:velocity];
        NSLog(@"%f",velocity);

    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        [self moveNeedle:-220];
    }

}



-(void) moveNeedle:(float)angl
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    
    if (angl >= 405) angl = 405;

    [self.needle setTransform: CGAffineTransformMakeRotation((M_PI / 180) * angl)];
    
    [UIView commitAnimations];
   
}


@end

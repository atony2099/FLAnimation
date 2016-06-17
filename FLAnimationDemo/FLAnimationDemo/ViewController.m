//
//  ViewController.m
//  FLAnimationDemo
//
//  Created by admin on 16/6/15.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FlAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)shakeHorizontally:(id)sender {
    
    [sender shakeHorizontal];
}

- (IBAction)shakeWithCompletionBlock:(id)sender {
    
    [sender shakeHorizontalWithCompletionBlock:^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                       message:@"This is a callback."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

- (IBAction)shakeVertically:(id)sender {
    [sender shakeVertical];
}

- (IBAction)expand:(id)sender {
    [sender expand];
}

- (IBAction)shrink:(id)sender {
    [sender shrink];
}

- (IBAction)rotate:(id)sender {
    [sender rotate];
    NSLog(@"test");
}


@end

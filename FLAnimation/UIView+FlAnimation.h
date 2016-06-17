//
//  UIView+FlAnimation.h
//  FLAnimationDemo
//
//  Created by admin on 16/6/15.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompletionBlock)();
@interface UIView (FlAnimation)

- (void)shakeHorizontal;
- (void)shakeVertical;
- (void)expand;
- (void)shrink;
- (void)rotate;

-  (void)shakeHorizontalWithCompletionBlock:(CompletionBlock)completionBlock;
-  (void)shakeVerticalWithCompletionBlock:(CompletionBlock)completionBlock;
-  (void)expandWithCompletionBlock:(CompletionBlock)completionBlock;
-  (void)shrinkWithCompletionBlock:(CompletionBlock)completionBlock;
-  (void)rotateWithCompletionBlock:(CompletionBlock)completionBlock;


- (void)shakeHorizontalWithDuration: (CGFloat)duration  CompletionBlock:(CompletionBlock)completionBlock;
- (void)shakeVerticalWithDuration:(CGFloat)duration  CompletionBlock:(CompletionBlock)completionBlock;
-  (void)rotateWithDuration:(CGFloat)duration  CompletionBlock:(CompletionBlock)completionBlock;

@end

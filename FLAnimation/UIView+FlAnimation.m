//
//  UIView+FlAnimation.m
//  FLAnimationDemo
//
//  Created by admin on 16/6/15.
//  Copyright © 2016年 fenglin. All rights reserved.
//

#import "UIView+FlAnimation.h"

#import "UIView+FlAnimation.h"
#import "POP.h"
#import <objc/runtime.h>

typedef NS_OPTIONS(NSUInteger, ChageType){

    ChageTypeHorizontal = 0,
    ChageTypeVertical,
    ChageTypeExpand,
    ChageTypeShrink,
    
};

typedef void (^CompletionBlock)();


@interface UIView ()

@property(nonatomic,copy)CompletionBlock completionHandle;
@property(nonatomic,assign)CGFloat duration;

@end

@implementation UIView (FlAnimation)

#pragma mark - public methods
-  (void)shakeHorizontal
{
    [self shakeWithType:ChageTypeHorizontal];
}

-  (void)shakeHorizontalWithCompletionBlock:(CompletionBlock)completionBlock
{
    self.completionHandle = completionBlock;
    [self shakeHorizontal];
}

- (void)shakeHorizontalWithDuration: (CGFloat)duration  CompletionBlock:(CompletionBlock)completionBlock
{
    self.duration = duration;
    [self shakeHorizontalWithCompletionBlock:completionBlock];
}

- (void)shakeVertical
{
    [self shakeWithType:ChageTypeVertical];
}

-  (void)shakeVerticalWithCompletionBlock:(CompletionBlock)completionBlock
{
    self.completionHandle = completionBlock;
    [self shakeVertical];
}

-  (void)shakeVerticalWithDuration:(CGFloat)duration CompletionBlock:(CompletionBlock)completionBlock
{
    self.duration = duration;
    [self shakeVerticalWithCompletionBlock:completionBlock];
}

- (void)expand
{
    [self scaleWithType:ChageTypeExpand];
}

-  (void)expandWithCompletionBlock:(CompletionBlock)completionBlock
{
    self.completionHandle = completionBlock;
    [self expand];
}

- (void)shrink
{
    [self scaleWithType:ChageTypeShrink];
}

-  (void)shrinkWithCompletionBlock:(CompletionBlock)completionBlock
{
    self.completionHandle = completionBlock;
    [self shrink];
}

- (void)rotate
{
    [self rotateAnimation];
}

-  (void)rotateWithCompletionBlock:(CompletionBlock)completionBlock
{
    self.completionHandle = completionBlock;
    [self rotate];
}

-  (void)rotateWithDuration:(CGFloat)duration CompletionBlock:(CompletionBlock)completionBlock
{
    self.duration = duration;
    [self rotateWithCompletionBlock:completionBlock];
}



#pragma mark - animation
- (void)shakeWithType:(ChageType)changeType
{
    
    if (self.duration == 0) {
        self.duration = 0.5f;
    }
    NSString *keyPath = nil;
    switch (changeType)
    {
            
        case ChageTypeHorizontal:
            keyPath = @"transform.translation.x";
            break;
        case ChageTypeVertical:
            keyPath = @"transform.translation.y";
            break;
        default:
            NSLog(@"shakeType Input error");
            return;
            break;
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation  animationWithKeyPath:keyPath];
    animation.delegate = self;
    animation.duration = self.duration ;
    CGFloat currentTx = self.transform.tx;
    animation.values = @[@(currentTx),@(currentTx+12),@(currentTx-12),@(currentTx+9),@(currentTx-9),@(currentTx+6),@(currentTx-6),@(currentTx)];
//    animation.timingFunction =  [CAMediaTimingFunction functionWithControlPoints: 0.130000 : 0.056667 : 0.053333 : 0.996667];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)scaleWithType:(ChageType)changeType
{
    CGFloat duration = 0.2f;
    NSValue *toValue = nil;
    switch (changeType)
    {
        case ChageTypeExpand:
            toValue = [NSValue valueWithCGSize:CGSizeMake(1.1f, 1.1f)];
            break;
        case ChageTypeShrink:
            toValue = [NSValue valueWithCGSize:CGSizeMake(0.9f, 0.9f)];
            break;
        default:
            NSLog(@"ScaleType Input error");
            return;
            break;
    }
    
    POPBasicAnimation *baseAni = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    baseAni.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    baseAni.toValue =  toValue;
    baseAni.duration = duration;
    [self.layer pop_addAnimation:baseAni forKey:nil];
    
    POPSpringAnimation *popAnimation = [POPSpringAnimation  animationWithPropertyNamed:kPOPLayerScaleXY];
    popAnimation.delegate = self;
    popAnimation.beginTime = CACurrentMediaTime() + 0.2f;
    popAnimation.springBounciness = 20.f;
    popAnimation.springSpeed = 20.f;
    popAnimation.fromValue = baseAni.toValue;
    popAnimation.toValue = baseAni.fromValue;
    [self.layer pop_addAnimation:popAnimation forKey:nil];
}

- (void)rotateAnimation
{
    if (self.duration == 0) {
        self.duration = 0.5f;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation  animationWithKeyPath:@"transform.rotation"];
    animation.delegate = self;
    animation.duration = self.duration;
    
    CGAffineTransform transF = self.transform;
    CGFloat curretnR = acos(transF.a);
    if (transF.b < 0) {
        curretnR = M_PI - curretnR;
    }
    animation.values = @[@(M_PI/40 + curretnR),@(-M_PI/40 + curretnR),@(M_PI/50 + curretnR),@(-M_PI/50 + curretnR),@(M_PI/60 + curretnR),@(-M_PI/60 + curretnR),@(curretnR),];
    
    //    animation.timingFunction =  [CAMediaTimingFunction functionWithControlPoints: 0.130000 : 0.056667 : 0.053333 : 0.996667];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:nil];
    
}


#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completionHandle) {
        self.completionHandle();
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if (self.completionHandle) {
        self.completionHandle();
    }
}

#pragma mark - setters and gettes
- (CompletionBlock)completionHandle
{
    return objc_getAssociatedObject(self, @selector(completionHandle));
}

- (void)setCompletionHandle:(CompletionBlock)completionHandle
{
    objc_setAssociatedObject(self, @selector(completionHandle), completionHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)duration
{
    return [objc_getAssociatedObject(self, @selector(duration)) floatValue];
}

- (void)setDuration:(CGFloat)duration
{
    objc_setAssociatedObject(self, @selector(duration), @(duration), OBJC_ASSOCIATION_RETAIN);
}


@end

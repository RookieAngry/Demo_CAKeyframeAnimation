//
//  AppDelegate.m
//  CALayer
//
//  Created by 陈天宇 on 16/7/16.
//  Copyright © 2016年 Angry_Rookie. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor orangeColor];
    UINavigationController *naVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    self.window.rootViewController = naVC;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = naVC.view.center;
    maskLayer.bounds = CGRectMake(0, 0, 60, 60);
    naVC.view.layer.mask = maskLayer;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    whiteView.backgroundColor = [UIColor whiteColor];
    [naVC.view addSubview:whiteView];
    [naVC.view bringSubviewToFront:whiteView];

    // whiteView Animation
    [UIView animateWithDuration:0.1 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        whiteView.alpha = 0;
    } completion:^(BOOL finished) {
        [whiteView removeFromSuperview];
    }];

    // maskLayer Animation
    CAKeyframeAnimation *maskLayerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    
    maskLayerAnimation.duration = 1;
    maskLayerAnimation.beginTime = CACurrentMediaTime() + 1.0f;//延迟一秒
    
    CGRect startRect = maskLayer.frame;
    
    CGRect tempRect = CGRectMake(0, 0, 100, 100);
    
    CGRect finalRect = CGRectMake(0, 0, 2000, 2000);
    
    maskLayerAnimation.values = @[[NSValue valueWithCGRect:startRect], [NSValue valueWithCGRect:tempRect], [NSValue valueWithCGRect:finalRect]];
    
    maskLayerAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    // 默认情况下动画结束后会回到初始状态,设置下面的两个属性可使动画结束后不回到初始位置并保持最后的状态
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    
    // 为图层添加动画效果
    [naVC.view.layer.mask addAnimation:maskLayerAnimation forKey:@"logoMaskAnimaiton"];
    
    // 实现控制器中内容的缩放动画
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        naVC.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            naVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            naVC.view.layer.mask = nil;
        }];
    }];
    
    return YES;
}

@end

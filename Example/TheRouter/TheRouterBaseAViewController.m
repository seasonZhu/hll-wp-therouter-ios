//
//  TheRouterBaseAViewController.m
//  TheRouter_Example
//
//  Created by mars.yao on 2024/4/9.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

#import "TheRouterBaseAViewController.h"

@implementation TheRouterBaseAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}

#pragma mark - ------------TheRouterableProxy------------
/// 重写实现协议中的类方法
+ (NSArray<NSString *>*)patternString {
    return @[@"scheme://router/baseA"];
}
@end

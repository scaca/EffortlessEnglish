//
//  CustomTabBarController.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/12.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "CustomTabBarController.h"
#import "PlayerTabBar.h"

@interface CustomTabBarController ()

@property(nonatomic, strong) PlayerTabBar *tabBarView;

@end

@implementation CustomTabBarController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self hideRealTabBar];
    [self customTabBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideRealTabBar {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            view.hidden = YES;
            break;
        }
    }
}

- (void)customTabBar {
    PlayerTabBar *tabBarView =
        [[PlayerTabBar alloc] initWithFrame:CGRectMake(0, kScreen_Height - 49, kScreen_Width, 49)];
    [self.view addSubview:tabBarView];

    self.tabBarView = tabBarView;
}

@end

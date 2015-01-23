//
//  ViewController.m
//  DFWelcomeDemo
//
//  Created by Stefanie on 15/1/23.
//  Copyright (c) 2015年 Stefanie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    UILabel * l = [[UILabel alloc]initWithFrame:screenBounds];
    l.numberOfLines = 0;
    l.textAlignment = NSTextAlignmentCenter;
    l.text = @"version 1.0.1 by xuchao \n 一切努力,只为巅峰!";
    [self.view addSubview:l];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

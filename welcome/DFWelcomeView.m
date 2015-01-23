//
//  DFWelcomeView.m
//  WeAreKit
//
//  Created by Stefanie on 15/1/22.
//  Copyright (c) 2015年 Stefanie. All rights reserved.
//

#import "DFWelcomeView.h"

static inline CGRect scrennRect(void)
{
    return [UIScreen mainScreen].bounds;
}

static NSString * const kWelcomeGuideKeyPaht = @"kWelcomGuideFisrtInterview";
static NSString * const kWelcomeGuideValue = @"iHaveAlreadyInterview";
static const CGFloat kDurationTime = 1.0f;
static const CGFloat kBesideBottom = 150.0f;

@interface DFWelcomeView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * imgNames;

@end

@implementation DFWelcomeView

+ (DFWelcomeView *)welcomeWithImageNames:(NSArray *)imgNames
{
    
    BOOL isFirstShow = [self checkTheWelcomeGuideFirstShow];
    if (!isFirstShow)
    {
        return nil;
    }
    
    CGRect screenRect = scrennRect();
    
    // Create & initialize
    DFWelcomeView * welcomeView = [[DFWelcomeView alloc]init];
    welcomeView.backgroundColor = [UIColor whiteColor];
    welcomeView.frame = screenRect;
    welcomeView.bounces = NO;
    welcomeView.imgNames = imgNames;
    welcomeView.contentSize = CGSizeMake((imgNames.count +1) * CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
    welcomeView.pagingEnabled = YES;
    welcomeView.showsHorizontalScrollIndicator = NO;
    welcomeView.delegate = welcomeView;

    // Create imageView
    [imgNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImage * image = [UIImage imageNamed:[imgNames objectAtIndex:idx]];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(idx * CGRectGetWidth(screenRect), 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
        [welcomeView addSubview:imageView];
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:kWelcomeGuideValue forKey:kWelcomeGuideKeyPaht];
    
    return welcomeView;
}

+ (BOOL)checkTheWelcomeGuideFirstShow
{
    NSString * welcomeGuideValue = [[NSUserDefaults standardUserDefaults] objectForKey:kWelcomeGuideKeyPaht];
    if ([welcomeGuideValue isEqualToString:kWelcomeGuideValue])
    {
        return NO;
    }
    else if(welcomeGuideValue == nil)
    {
        return YES;
    }
    return YES;
}

- (void)welcomeHidden
{
    [self removeFromSuperview];
}

#pragma mark - protocal scrollview method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect screenRect = scrennRect();
    
    CGFloat offsetAlpha = scrollView.contentOffset.x - (_imgNames.count - 1) * CGRectGetWidth(screenRect);
    if (offsetAlpha > 0)
    {
        self.alpha = 1.0f - offsetAlpha / CGRectGetWidth(screenRect);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect screenRect = scrennRect();

    if (scrollView.contentOffset.x >= _imgNames.count * CGRectGetWidth(screenRect))
    {
        [self welcomeHidden];
    }
}

#pragma mark - enter
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect scrrenRect = scrennRect();
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if ((point.x > (_imgNames.count - 1) * CGRectGetWidth(scrrenRect))
        && (point.y > CGRectGetHeight(scrrenRect) - kBesideBottom))
    {
        [UIView animateWithDuration:kDurationTime animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self welcomeHidden];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

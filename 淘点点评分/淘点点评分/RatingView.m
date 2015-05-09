//
//  RatingView.m
//  淘点点评分
//
//  Created by XWQ on 15/4/27.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import "RatingView.h"
#import "JTSlideShadowAnimation.h"

@interface RatingView()
@property (nonatomic,strong) UIImageView *bottomView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,assign) CGFloat starWidth;
@property (nonatomic,strong) UIImageView *haceImage;
@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;
@property (strong, nonatomic)  UIButton *animatedView;

@end

@implementation RatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bottomView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.bottomView.backgroundColor = [UIColor orangeColor];
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50,self.bounds.size.height)];
        self.topView.backgroundColor = [UIColor redColor];
        self.haceImage = [[UIImageView alloc]init];
        self.haceImage.frame = CGRectMake(0, 0, 50, 50);
        self.haceImage.backgroundColor = [UIColor greenColor];
        self.haceImage.layer.cornerRadius = 25;
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        [self.topView addSubview:self.haceImage];
        
        
        self.topView.clipsToBounds = NO;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        
        CGFloat width = frame.size.width/6.0;
        self.starWidth = width;

        self.layer.cornerRadius = 25;
        self.topView.layer.cornerRadius = 25;
        
        
        self.animatedView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.animatedView.frame = CGRectMake(10,0, self.frame.size.width-10*2, 50);
        [self.animatedView setTitle: @"滑动评价》" forState:UIControlStateNormal];
        [self.animatedView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.animatedView];
        
        self.shadowAnimation = [JTSlideShadowAnimation new];
        self.shadowAnimation.animatedView = self.animatedView;
        self.shadowAnimation.shadowWidth = 40.;
        [self.shadowAnimation start];

        
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    CGPoint btnPointInA = [self.animatedView convertPoint:point fromView:self];
    if ([self.bottomView pointInside:btnPointInA withEvent:event]) {
        return self.bottomView;
    }
    else if([self.animatedView pointInside:btnPointInA withEvent:event])
    {
        return self.animatedView;
    }
    return [super hitTest:point withEvent:event];
}
-(void)setStarNumber:(NSInteger)starNumber
{
    if(self.starNumber!=starNumber){
        self.starNumber = starNumber;
        self.topView.frame = CGRectMake(0, 0, self.starWidth*(starNumber+1), self.bounds.size.height);
    }

}
-(void)setBgImage:(UIImage *)bgImage
{
    if (self.bottomView.image != bgImage) {
        self.bottomView.image = bgImage;
    }
}

-(void)tap:(UITapGestureRecognizer *)gesture{
    [self.animatedView removeFromSuperview];
    if(self.enable)
    {
        NSLog(@"-------");
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth)+1;
        [UIView animateWithDuration:0.8 animations:^{
            self.topView.frame = CGRectMake(0, 0, self.starWidth*count, self.bounds.size.height);
            self.haceImage.frame = CGRectMake(self.topView.frame.size.width-50, 0, 50, 50);
        } completion:^(BOOL finished) {
            if(count>5){
                _starNumber = 5;
            }else{
                _starNumber = count-1;
            }
            [UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
                
                
            } completion:^(BOOL finished) {
                CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
                shake.fromValue = [NSNumber numberWithFloat:-5];
                shake.toValue = [NSNumber numberWithFloat:5];
                shake.duration = 0.1;//执行时间
                shake.autoreverses = YES; //是否重复
                shake.repeatCount = 2;//次数
                [self.haceImage.layer addAnimation:shake forKey:@"shakeAnimation"];
            }];
        }];
        
        
        
        if(count>5){
            _starNumber = 5;
        }else{
            _starNumber = count-1;
        }
       

    }
}
-(void)pan:(UIPanGestureRecognizer *)gesture{
    [self.animatedView removeFromSuperview];
    if(self.enable)
    {
        NSLog(@"++++++");
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth);
        if(count>=0 && count<=5 && _starNumber!=count){
            
            [UIView animateWithDuration:0.8 animations:^{
                self.topView.frame = CGRectMake(0, 0, self.starWidth*(count+1), self.bounds.size.height);
                self.haceImage.frame = CGRectMake(self.topView.frame.size.width-50, 0, 50, 50);
                _starNumber = count;
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
                    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
                    shake.fromValue = [NSNumber numberWithFloat:-5];
                    shake.toValue = [NSNumber numberWithFloat:5];
                    shake.duration = 0.1;//执行时间
                    shake.autoreverses = YES; //是否重复
                    shake.repeatCount = 2;//次数
                    [self.haceImage.layer addAnimation:shake forKey:@"shakeAnimation"];
                } completion:^(BOOL finished) {
                 }];

            }];
            
        }
       

    }
}





@end

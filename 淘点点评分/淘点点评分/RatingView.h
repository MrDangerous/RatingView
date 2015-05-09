//
//  RatingView.h
//  淘点点评分
//
//  Created by XWQ on 15/4/27.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView

/*
 *
 */
@property (nonatomic,assign) NSInteger starNumber;

/*
 *调整底部视图的图片
 */
@property (nonatomic,strong) UIImage *bgImage;


/*
 *是否允许可触摸
 */
@property (nonatomic,assign) BOOL enable;

@end

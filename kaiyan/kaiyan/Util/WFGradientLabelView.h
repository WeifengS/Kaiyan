//
//  WFGradientLabelView.h
//  kaiyan
//
//  Created by Apple on 2018/4/19.
//  Copyright © 2018年 shiweifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WFGradientLabelView : UIView
+(WFGradientLabelView*) labelViewWithFirstLabelTitils:(NSArray *)firstLabelTitils secondLabelTitils:(NSArray *)secondLabelTitils firstFont:(UIFont*)fistFont secondFont:(UIFont*)secondFont andFrame:(CGRect)frame animateDuration:(NSTimeInterval)animateDuration;
-(void)actionAnimate;
@property (nonatomic,strong) UILabel * firstLabel;
@property (nonatomic,strong) UILabel * secondLabel;
@property (nonatomic,strong) NSArray <NSString*>* firstTitleArr;
@property (nonatomic,strong) NSArray <NSString*>* secondTitleArr;
/**文字颜色 默认白色*/
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,assign) CGRect endFrame;
@property (nonatomic,assign) NSInteger pageIndex;
@end

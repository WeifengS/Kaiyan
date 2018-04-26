//
//  WFGradientLabelView.m
//  kaiyan
//
//  Created by Apple on 2018/4/19.
//  Copyright © 2018年 shiweifeng. All rights reserved.
//

#import "WFGradientLabelView.h"

@interface WFGradientLabelView()
@property (nonatomic,assign)NSTimeInterval animateDuration;

@end
@implementation WFGradientLabelView
+(WFGradientLabelView*) labelViewWithFirstLabelTitils:(NSArray <NSString*>*)firstLabelTitils secondLabelTitils:(NSArray <NSString*>*)secondLabelTitils firstFont:(UIFont*)fistFont secondFont:(UIFont*)secondFont andFrame:(CGRect)frame animateDuration:(NSTimeInterval)animateDuration{
    WFGradientLabelView * labView = [[WFGradientLabelView alloc]init];
    labView.frame = frame;
    labView.width = 0;
    labView.animateDuration = animateDuration;
    labView.endFrame = frame;
    
    labView.firstLabel = [[UILabel alloc]init];
      labView.firstLabel.font = fistFont;
    labView.firstLabel.numberOfLines = 0;
    labView.firstLabel.width = frame.size.width;
    labView.firstLabel.text = firstLabelTitils.firstObject;
    if (secondLabelTitils && secondLabelTitils.count > 0) {
        [labView.firstLabel sizeToFit];
        labView.firstLabel.frame = CGRectMake(0, 0, frame.size.width, labView.firstLabel.height);
    }else{
        labView.firstLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    
  
    labView.firstLabel.textColor = [UIColor whiteColor];
    labView.firstLabel.textAlignment = NSTextAlignmentCenter;

    
    labView.secondLabel = [[UILabel alloc]init];
    labView.secondLabel.font = secondFont;
    labView.secondLabel.text = secondLabelTitils.firstObject;
    labView.secondLabel.width = frame.size.width;
    [labView.secondLabel sizeToFit];
    labView.secondLabel.frame = CGRectMake(0,  CGRectGetMaxY(labView.firstLabel.frame) + 5, frame.size.width, labView.secondLabel.height);
    labView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, labView.firstLabel.height + labView.secondLabel.height +5);
    
    labView.secondLabel.textColor = [UIColor whiteColor];
    labView.secondLabel.textAlignment = NSTextAlignmentCenter;
    labView.secondLabel.numberOfLines = 0;
    labView.clipsToBounds = YES;
    [labView addSubview:labView.firstLabel];
    [labView addSubview:labView.secondLabel];
    labView.firstTitleArr = firstLabelTitils;
    labView.secondTitleArr = secondLabelTitils;
    return labView;
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.firstLabel.textColor  = titleColor;
    self.secondLabel.textColor = titleColor;
}
-(void)setPageIndex:(NSInteger)pageIndex{
    _pageIndex = pageIndex;
    if (self.firstTitleArr[pageIndex]) {
        self.firstLabel.text = self.firstTitleArr[pageIndex];
    }
    if (self.secondTitleArr[pageIndex]) {
        self.secondLabel.text = self.secondTitleArr[pageIndex];
    }
}
-(void)actionAnimate{
    self.width = 0;
    self.titleColor = [UIColor whiteColor];
    [UIView animateWithDuration:self.animateDuration animations:^{
        self.width = self.endFrame.size.width;
    } completion:^(BOOL finished) {
        NSLog(@"%@",NSStringFromCGRect(self.frame));
    }];
    
}
@end

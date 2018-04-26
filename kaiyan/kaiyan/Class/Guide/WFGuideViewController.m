//
//  WFGuideViewController.m
//  kaiyan
//
//  Created by Apple on 2018/4/18.
//  Copyright © 2018年 shiweifeng. All rights reserved.
//

#import "WFGuideViewController.h"
#import "WFFontUtil.h"
//#import <CoreText/CTFontManager.h>
#import "WFGradientLabelView.h"
#import "WFNetWork.h"

@interface WFGuideViewController ()<UIGestureRecognizerDelegate>
//@property(nonatomic,strong)UILabel * textLabel;
@property(nonatomic,strong) WFGradientLabelView * labelView;
@property(nonatomic,assign) CGFloat startX;
@property(nonatomic,strong) NSArray * chineseTitlesArr;
@property(nonatomic,strong) NSArray * englishTitlesArr;
@property(nonatomic,strong) UIPageControl * pageControl;
@property(nonatomic,assign) double moveDistance;
@property(nonatomic,assign)BOOL endPass;
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation WFGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"ic_account_login_header" ];
    UIImageView * headerIconView = [[UIImageView alloc]initWithImage:image];
    [headerIconView sizeToFit];
    [self.view addSubview:headerIconView];
    headerIconView.sd_layout.topSpaceToView(self.view, 200).centerXEqualToView(self.view).widthIs(150).heightIs(56);
    NSString * path = [[NSBundle mainBundle] bundlePath];
   
       [WFFontUtil fontName];
    NSLog(@"%@",path);

    UIFont * secondFont = [UIFont fontWithName:@"Lobster1.4" size:16];
    UIFont * firstFont = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
//    UIFont * firstFont = [UIFont systemFontOfSize:15];
    self.chineseTitlesArr = @[@"每日编辑精选，一如既往",@"关注愈多，发现愈多",@"离线自动缓存，精彩永不下线",@"登录即可订阅、评论和同步已收藏视频"];
    self.englishTitlesArr = @[@"Daily appetizers for your eyes,as always",@"Subscribe more,diacover a whole lot more",@"EyepetizerThree",@"EyepetizerFour"];
    
    self.labelView = [WFGradientLabelView labelViewWithFirstLabelTitils:self.chineseTitlesArr secondLabelTitils:self.englishTitlesArr firstFont:firstFont secondFont:secondFont andFrame:CGRectMake(50, self.view.height - 200, UIScreenWidth - 100, 100) animateDuration:1.5];
    [self.view addSubview:self.labelView];
    [self.labelView actionAnimate];

    UIPanGestureRecognizer * ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    ges.delegate = self;
    [self.view addGestureRecognizer:ges];
    ges.cancelsTouchesInView=NO;
    
    UIPageControl * page = [[UIPageControl alloc]init];
    page.tintColor = [UIColor whiteColor];
    [self.view addSubview:page];
    page.numberOfPages =self.chineseTitlesArr.count;
    page.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.labelView, 20)
    .heightIs(20);
    self.pageControl = page;
    [self.pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.selected = NO;
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSString * url = @"http://baobab.kaiyanapp.com/api/v5/index/tab/allRec?page=0&udid=1de8777ed6c34b839b8b5b67184e898da885a7f5&vc=276&vn=3.15&deviceModel=MI%206&first_channel=eyepetizer_xiaomi_market&last_channel=eyepetizer_xiaomi_market&system_version_code=26";
//    [WFNetWork GET:@"http://baobab.kaiyanapp.com/api/v5/index/tab/allRec?page=0&udid=1de8777ed6c34b839b8b5b67184e898da885a7f5&vc=276&vn=3.15&deviceModel=MI%206&first_channel=eyepetizer_xiaomi_market&last_channel=eyepetizer_xiaomi_market&system_version_code=26" parameters:nil success:^(id responseObject) {

    [WFNetWork GET:url parameters:nil responseCache:^(id responseCache) {
        NSLog(@"%@",responseCache);
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)pageAction:(UIPageControl*)sender{
    self.labelView.pageIndex = sender.currentPage;
    [self.labelView actionAnimate];
}
-(void)changeTitlesPageIndex:(NSInteger)Index{
    if (Index < 0) {
        self.currentIndex = 0;
        Index = self.chineseTitlesArr.count-1;
        return;
    }
    if (self.moveDistance < UIScreenWidth/5) {
        return;
    }
    if (Index == self.chineseTitlesArr.count) {
        Index = 0;
        self.currentIndex = self.chineseTitlesArr.count;
        return;
    }
    self.labelView.pageIndex = Index;
    self.currentIndex = Index;
//    NSString * title = self.titlesArr[Index];


    self.pageControl.currentPage = Index;
    [self.labelView actionAnimate];
    
    
}
- (void)click:(UIPanGestureRecognizer *)recognizer{
    NSLog(@"11111");
   
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.startX =[recognizer locationInView:self.view].x;
        NSLog(@"开始");
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self commitTranslation:[recognizer translationInView:self.view]];
        NSLog(@"移动");
    }
    if (recognizer.state == UIGestureRecognizerStateEnded){
        if (self.endPass) {
            [self loadData];
            return;
        }else{
            self.startX = 0;
            
            self.labelView.titleColor = [UIColor whiteColor];
            [self changeTitlesPageIndex:self.currentIndex];
        }
       
    }

    NSLog(@"%ld(long)",(long)recognizer.state);
}
-(void)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < 10)
        return;
    
    
    if (absX > absY ) {
        
        if (translation.x<0) {
            NSLog(@"向左滑动");
            NSLog(@"%f",translation.x);
            double x = ABS(translation.x);
            double max =(UIScreenWidth -  self.startX) >self.startX?(UIScreenWidth -  self.startX):self.startX;
            double mind =  (max - x)/max;
              NSLog(@"%f/%f/%f",self.startX,x,mind);
            if (mind < 0.3) {
                mind = 0.3;
            }
            self.moveDistance = x;
            self.labelView.titleColor = UIColorFromRGBA(0xffffff, mind);
            self.currentIndex = self.pageControl.currentPage + 1;
            //向左滑动
        }else{
            NSLog(@"向右滑动");
            NSLog(@"%f",translation.x);
            double x = ABS(translation.x);
            double max =(UIScreenWidth -  self.startX) >self.startX?(UIScreenWidth -  self.startX):self.startX;
            double mind =(max - x)/max;
            NSLog(@"%f/%f/%f",self.startX,x,mind);
            if (mind < 0.3) {
                mind = 0.3;
            }
            self.moveDistance = x;
            self.labelView.titleColor = UIColorFromRGBA(0xffffff, mind);
            
            self.currentIndex = self.pageControl.currentPage - 1;
            //向右滑动
        }
        
    } else if (absY > absX) {
        if (translation.y<0) {
            self.endPass = YES;
            //向上滑动
        }else{
            
            //向下滑动
        }
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

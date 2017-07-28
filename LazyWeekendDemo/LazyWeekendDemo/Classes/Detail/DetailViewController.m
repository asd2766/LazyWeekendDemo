//
//  DetailViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/27.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "DetailViewController.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

@interface DetailViewController ()<UIScrollViewDelegate, SGFocusImageFrameDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *topContentView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIView *pointLeftView;
@property (weak, nonatomic) IBOutlet UIView *pointRightView;
@property (weak, nonatomic) IBOutlet UIImageView *leftLineImageView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) SGFocusImageFrame *focusBanner;

@property (nonatomic) CGFloat bannerHeight;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_left_white"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    
    // 右边按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_share_white"] style:UIBarButtonItemStyleDone target:self action:@selector(shareActivity)];
    UIBarButtonItem *collectionBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_heart_white_off"] style:UIBarButtonItemStyleDone target:self action:@selector(collectClick)];
    UIBarButtonItem *contactBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_help_white"] style:UIBarButtonItemStyleDone target:self action:@selector(contact)];
    self.navigationItem.rightBarButtonItems = @[shareBtn, collectionBtn, contactBtn];
    
    // 页面相关处理
    [CommonUtil addViewAttr:self.pointLeftView borderWidth:0 borderColor:nil cornerRadius:CGRectGetHeight(self.pointLeftView.frame)/2];
    [CommonUtil addViewAttr:self.pointRightView borderWidth:0 borderColor:nil cornerRadius:CGRectGetHeight(self.pointRightView.frame)/2];
    self.leftLineImageView.transform = CGAffineTransformMakeRotation(M_PI);
    
    // 计算高度
    _bannerHeight = ceil(_screenWidthRatio_375 * 200);
    self.bannerHeightConstraint.constant = _bannerHeight;
    self.topContentView.frame = CGRectMake(0, 0, _screenWidth, 447 - 200 + _bannerHeight);
    [self.mainScrollView addSubview:self.topContentView];
    self.mainScrollView.contentSize = CGSizeMake(_screenWidth, CGRectGetHeight(self.topContentView.frame) + _screenHeight + 44);
    self.mainScrollView.delegate = self;
    
    // 数据处理
    [self handleData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据处理
- (void)handleData {
    // 标题
    self.titleLabel.text = self.detailDic.activityTitle;
    
    // 价格
    NSString *price = [NSString stringWithFormat:@"￥%@", self.detailDic.activityPrice];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:price];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    self.priceLabel.attributedText = str;
    
    // 日期
    self.timeLabel.text = self.detailDic.activityTime ? self.detailDic.activityTime : @"";
    
    //地点
    self.locationLabel.text = self.detailDic.activityLocation;
    
    // 图片 (模拟数据)
    NSMutableArray *loopArray = [NSMutableArray array];
    SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:@"" imageUrl:@"http://www.cdtianya.com/Public/Uploads/image/20150416/20150416173303_51276.jpg" tag:0];
    [loopArray addObject:item];
    
    item = [[SGFocusImageItem alloc] initWithTitle:@"" imageUrl:@"http://www.khvip.com/files/2015-6/20150613150254184155.jpg" tag:1];
    [loopArray addObject:item];
    
    item = [[SGFocusImageItem alloc] initWithTitle:@"" imageUrl:@"http://www.youbian.com/Images/Articles/2016-03-09/3668457683.jpg" tag:2];
    [loopArray addObject:item];
    
    self.focusBanner = [[SGFocusImageFrame alloc] initWithFrame:self.bannerView.bounds delegate:self imageItems:loopArray isAuto:YES imageType:UIViewContentModeScaleToFill];
    [self.bannerView addSubview:self.focusBanner];
}

#pragma mark - SGFocusImageFrameDelegate

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item {
    NSLog(@"banner 点击图片 %@", item.imageUrl);
}

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index {
    NSLog(@"banner 点击 %d", index);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        self.bannerHeightConstraint.constant = _bannerHeight - offsetY;
        self.topContentView.frame = CGRectMake(0, offsetY, _screenWidth, 447 - 200 + _bannerHeight - offsetY);
        
        [self.focusBanner updateFrame:CGRectMake(0, 0, _screenWidth, _bannerHeight - offsetY) focusImageType:SGFocusOnlyImageAndPageControl];
        
    } else if (self.bannerHeightConstraint.constant != _bannerHeight){
        self.bannerHeightConstraint.constant = _bannerHeight;
        self.topContentView.frame = CGRectMake(0, 0, _screenWidth, 447 - 200 + _bannerHeight);
        [self.focusBanner updateFrame:CGRectMake(0, 0, _screenWidth, _bannerHeight) focusImageType:SGFocusOnlyImageAndPageControl];
    }
}

#pragma mark -- action

/**
 分享
 */
- (void)shareActivity {
    
}


/**
 收藏/取消收藏
 */
- (void)collectClick {
    
}


/**
 联系客服, 帮助
 */
- (void)contact {
    
}


@end

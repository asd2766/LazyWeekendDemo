//
//  DSLoopDbImageFrame.m
//  wedding
//
//  Created by Jianyong Duan on 14/12/12.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import "DSLoopDbImageFrame.h"
#import "SGFocusImageItem.h"
#import "UIImageView+WebCache.h"
#import "Consts.h"
#define ITEM_WIDTH self.frame.size.width

@interface DSLoopDbImageFrame () {
    
}

@property (nonatomic, strong) NSArray *orgileItems;
@property (nonatomic, strong) NSMutableArray *imageItems;
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic) int scrollInterval;

- (void)setupViews;

@end

static int SWITCH_FOCUS_PICTURE_INTERVAL = 5; //switch interval time

@implementation DSLoopDbImageFrame

- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES displayType:0];
}

- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto  displayType:(int)displayType {
    self = [super initWithFrame:frame];
    if (self)
    {
        _displayType = displayType;
        
        self.orgileItems = [NSArray arrayWithArray:items];
        
        self.imageItems = [NSMutableArray array];
        if (items.count > 0) {
            //两条一起循环
            NSInteger count = items.count;
            NSMutableArray *dbItems = [NSMutableArray array];
            
            for (int i = 0; i < count; i++) {
                [dbItems addObject:items[i]];
                if (dbItems.count == 2 || i == count - 1) {
                    [self.imageItems addObject:dbItems];
                    dbItems = [NSMutableArray array];
                }
            }
            
            if (_imageItems.count > 1) {
                //增加第一条和最后一条
                [self.imageItems insertObject:_imageItems[_imageItems.count - 1] atIndex:0];
                [self.imageItems addObject:_imageItems[1]];
            }
        }
        
        _isAutoPlay = isAuto;
        [self setupViews];
        
        if (_imageItems.count <= 1) {
            self.pageControl.hidden = YES;
        }
        
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES];
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _delegate = nil;
}


#pragma mark - private methods
- (void)setupViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    float space = 0;
    float devide = 0;
    float heightPad = 0;
    CGSize size = CGSizeMake(320, 0);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height -15, CGRectGetWidth(self.bounds), 15)];
    if (_displayType == 1) {
        _pageControl.frame = CGRectMake(0, self.frame.size.height -26, CGRectGetWidth(self.bounds), 26);
        space = 8;
        heightPad = 27;
        devide = 10;
    } else if (_displayType == 2) {
        _pageControl.frame = CGRectMake(0, self.frame.size.height -26, CGRectGetWidth(self.bounds), 26);
        space = 10;
        heightPad = 54;
        devide = 10;
    }else if (_displayType == 3){
        
        if(_imageItems.count > 2){
            _pageControl.frame = CGRectMake(0, self.frame.size.height -15, CGRectGetWidth(self.bounds), 20);
        }else{
            _pageControl.hidden = YES;
        }
        heightPad = 10;
        _scrollView.backgroundColor = RGB(247, 247, 247);


    }
    else {
        _scrollView.backgroundColor = RGB(247, 247, 247);
    }
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    /*
     _scrollView.layer.cornerRadius = 10;
     _scrollView.layer.borderWidth = 1 ;
     _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
     */
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = _imageItems.count>1?_imageItems.count -2:_imageItems.count;
    _pageControl.currentPage = 0;
    
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageItems.count, _scrollView.frame.size.height);
    
    for (int i = 0; i < _imageItems.count; i++) {
        
        NSArray *items = [_imageItems objectAtIndex:i];
        
        for (int j=0; j < items.count; j++) {
            
            SGFocusImageItem *item = [items objectAtIndex:j];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+_scrollView.frame.size.width/2*j + (j>0?devide/2:space), 0, _scrollView.frame.size.width/2-space-devide/2, _scrollView.frame.size.height-size.height - heightPad)];
            
            //加载图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil];
            imageView.userInteractionEnabled = YES;
            imageView.tag = item.tag;
            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
            [imageView addGestureRecognizer:tapGestureRecognize];
            
            [_scrollView addSubview:imageView];
            
            //商品表示
            if (_displayType == 2) {
                
                if (item.price) {
                    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(imageView.frame) - 30, CGRectGetWidth(imageView.frame), 30)];
                    maskView.backgroundColor = RGBA(0, 0, 0, .4);
                    
                    maskView.userInteractionEnabled = YES;
                    maskView.tag = item.tag;
                    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
                    [maskView addGestureRecognizer:tapGestureRecognize];
                    
                    //价格
                    UILabel *labelPrice = [[UILabel alloc] initWithFrame:maskView.bounds];
                    labelPrice.font = [UIFont systemFontOfSize:15.0];
                    labelPrice.textColor = [UIColor whiteColor];
                    labelPrice.textAlignment = NSTextAlignmentCenter;
                    labelPrice.text = item.price;
                    [maskView addSubview:labelPrice];
                    
                    [_scrollView addSubview:maskView];
                }
                
                //商品名称
                UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(imageView.frame), CGRectGetWidth(imageView.frame), 35)];
                labelTitle.font = [UIFont systemFontOfSize:14.0];
                labelTitle.textColor = RGB(51, 51, 51);
                labelTitle.textAlignment = NSTextAlignmentCenter;
                labelTitle.text = item.title;
                [_scrollView addSubview:labelTitle];
            }
            
        }
    }
    
    if ([_imageItems count]>1)
    {
        [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH, 0) animated:NO] ;
        
        if (_isAutoPlay) {
            
            self.scrollInterval = 0;
            self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(switchFocusImageItems:) userInfo:nil repeats:YES];
        }
    }
}

- (void)switchFocusImageItems:(NSTimer *)timer
{
    self.scrollInterval++;
    if (self.scrollInterval < SWITCH_FOCUS_PICTURE_INTERVAL) {
        return;
    }
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    
    targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
    [self moveToTargetPosition:targetX];
    
    self.scrollInterval = 0;
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    UIView *view = gestureRecognizer.view;
    if (view.tag > -1 && view.tag < _orgileItems.count) {
        SGFocusImageItem *item = [_orgileItems objectAtIndex:view.tag];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
        }
    }
//    
//    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
//    if (page > -1 && page < _imageItems.count) {
//        SGFocusImageItem *item = [_imageItems objectAtIndex:page];
//        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
//            [self.delegate foucusImageFrame:self didSelectItem:item];
//        }
//    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    
    if ([_imageItems count]>=3)
    {
        if (targetX >= ITEM_WIDTH * ([_imageItems count] -1)) {
            targetX = ITEM_WIDTH;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = ITEM_WIDTH *([_imageItems count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x+ITEM_WIDTH/2.0) / ITEM_WIDTH;
    //    NSLog(@"%f %d",_scrollView.contentOffset.x,page);
    if ([_imageItems count] > 1)
    {
        page --;
        if (page >= _pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pageControl.numberOfPages -1;
        }
    }
    if (page!= _pageControl.currentPage)
    {
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(foucusImageFrame:currentItem:)])
        {
            [self.delegate foucusImageFrame:self currentItem:(int)page];
        }
    }
    _pageControl.currentPage = page;
    
    self.scrollInterval = 0;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPosition:targetX];
    }
}

- (void)scrollToIndex:(int)aIndex
{
    if ([_imageItems count]>1)
    {
        if (aIndex >= ([_imageItems count]-2))
        {
            aIndex = (int)[_imageItems count]-3;
        }
        [self moveToTargetPosition:ITEM_WIDTH*(aIndex+1)];
    }else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
}

@end

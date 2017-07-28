//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "UIImageView+WebCache.h"
#import "Consts.h"
#import "TopicItem.h"
#import "ZXLabel.h"
#import "CommonUtil.h"

#define ITEM_WIDTH self.frame.size.width
#define ITEM_HEIGHT self.frame.size.height
@interface SGFocusImageFrame () {
    BOOL _isVertical; //是否是垂直滚动

}

@property (nonatomic, strong) NSMutableArray *imageItems;

@property (nonatomic) int scrollInterval;

- (void)setupViews;

// 参数
@property (nonatomic, assign) id<SGFocusImageFrameDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *autoScrollTimer;

@property(nonatomic, assign) UIViewContentMode imageType;//imageView展示类型

@end

static int SWITCH_FOCUS_PICTURE_INTERVAL = 5.0f; //switch interval time

@implementation SGFocusImageFrame

/**
 初始化

 @param frame frame
 @param delegate 代理
 @param items 图片数组
 @param isAuto 是否自动滚动
 @param focusImageType 展示类型
 @param isVertical 是否垂直滚动
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType )focusImageType andWithisVertical:(BOOL )isVertical{
    self.imageType = UIViewContentModeScaleAspectFit;
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageItems = [NSMutableArray arrayWithArray:items];
        if (items.count > 1) {
            //增加最后一条和第一条循环
            [self.imageItems insertObject:items[items.count - 1] atIndex:0];
            [self.imageItems addObject:items[0]];
        }
        _isVertical = isVertical;
        _isAutoPlay = isAuto;
        [self setupViewsWith:focusImageType];
        
        [self setDelegate:delegate];
    }
    return self;
}


/**
 初始化页面

 @param frame frame
 @param delegate 代理
 @param items 展示内容(数组)
 @param isAuto 是否自动滚动
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES focusImageType: SGFocusOnlyImageAndPageControl imageType:UIViewContentModeScaleAspectFit];
}

/**
 初始化页面

 @param frame frame
 @param delegate 代理
 @param items 展示的内容(数组)
 @param isAuto 是否自动滚动
 @param type 图片的展示类型(宽高自适应, 拉伸等)
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto imageType:(UIViewContentMode)type{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES focusImageType: SGFocusOnlyImageAndPageControl imageType:type];
    
}

/**
 初始化页面

 @param frame frame
 @param delegate 代理
 @param items 展示的内容(数组)
 @param isAuto 是否自动滚动
 @param focusImageType 展示类型
 @param type 图片的展示类型(宽高自适应, 拉伸等)
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType)focusImageType imageType:(UIViewContentMode)type{
    self.imageType = type;
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageItems = [NSMutableArray arrayWithArray:items];
        if (items.count > 1) {
            //增加最后一条和第一条循环
            [self.imageItems insertObject:items[items.count - 1] atIndex:0];
            [self.imageItems addObject:items[0]];
        }
        
        if (focusImageType == SGFocusOneyText||focusImageType == SGFocusOneyTradeText || focusImageType == SGFocusNews) {
            _isVertical = YES;//垂直滚动
        }
        _isAutoPlay = isAuto;
        _focusImageType = focusImageType;
//        [self setupViews];
        [self setupViewsWith:focusImageType];
        
//        if (items.count <= 1) {
//            self.pageControl.hidden = YES;
//        }
        
        [self setDelegate:delegate];
    }
    return self;
}

/**
 初始化页面

 @param frame frame
 @param delegate 代理
 @param items 展示内容(数组)
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES imageType:UIViewContentModeScaleAspectFit];
}

- (void)dealloc
{
    self.delegate = nil;
    _scrollView.delegate = nil;
}

#pragma mark - private methods
- (void)setupViewsWith:(SGFocusImageType )focusImageType
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    float space = 0;
    //    CGSize size = CGSizeMake(ITEM_WIDTH, 0);
    [self addSubview:_scrollView];
    
    /*
     _scrollView.layer.cornerRadius = 10;
     _scrollView.layer.borderWidth = 1 ;
     _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
     */
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _imageItems.count>1?_imageItems.count -2:_imageItems.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = RGB(204, 0, 0);
    _pageControl.pageIndicatorTintColor = RGB(188, 188, 188);
    _pageControl.hidden = NO;
    
    switch (focusImageType) {
        case SGFocusOnlyImageAndPageControl:
        {
            _pageControl.frame = CGRectMake(0, self.frame.size.height -16-10, CGRectGetWidth(self.bounds), 10);
            _pageControl.userInteractionEnabled = NO;
            [self addSubview:_pageControl];

            
            for (int i = 0; i < _imageItems.count; i++) {
                SGFocusImageItem *item = [_imageItems objectAtIndex:i];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                imageView.tag = i + 10;
                //加载图片
                if (_focusImageType == SGFocusUIImageType) {
                    imageView.image = item.image;
                }else{

                    [CommonUtil setSDWebImageProperties];
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        // 图片展示类型
                        imageView.contentMode = self.imageType;
                    }];
                }
                
                //修改视图显示模式
                [imageView setClipsToBounds:YES];
                [_scrollView addSubview:imageView];
            }
            
            // single tap gesture recognizer
            UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
            tapGestureRecognize.delegate = self;
            tapGestureRecognize.numberOfTapsRequired = 1;
            [_scrollView addGestureRecognizer:tapGestureRecognize];
            _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageItems.count, _scrollView.frame.size.height);
        }
            break;
        case SGFocusOnlyImage:
        {
            for (int i = 0; i < _imageItems.count; i++) {
                SGFocusImageItem *item = [_imageItems objectAtIndex:i];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                imageView.tag = i + 10;
                //显示图片
                if (_focusImageType == SGFocusUIImageType) {
                    imageView.image = item.image;
                }else{
                    
                    [CommonUtil setSDWebImageProperties];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        // 图片展示类型
                        imageView.contentMode = self.imageType;
                    }];
                }
                
                [imageView setClipsToBounds:YES];
                [_scrollView addSubview:imageView];
            }
        }
            break;
        case SGFocusOneyTradeText :{
            //设置scrollview的contentSize
            if (_isVertical) {
                
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height*_imageItems.count);
            }else {
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *_imageItems.count , _scrollView.frame.size.height);
            }
                //交易信息
            for (int i =0; i<_imageItems.count; i++) {
                NSString * str =_imageItems[i];
                
                ZXLabel * label = nil;
                if (_isVertical) {
                     label = [[ZXLabel alloc] initWithFrame:CGRectMake(space, i*_scrollView.frame.size.height+space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                }else{
                    label = [[ZXLabel alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width + space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                }
            
                label.text = str;
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = RGB(67, 67, 67);
                [label adjustFont];
                [_scrollView addSubview:label];
                
                UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
                tapGestureRecognize.delegate = self;
                tapGestureRecognize.numberOfTapsRequired = 1;
                [label addGestureRecognizer:tapGestureRecognize];
                label.userInteractionEnabled = YES;
            }
    
        }
            break;
        case SGFocusNews :{
            //设置scrollview的contentSize
            if (_isVertical) {
                
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height*_imageItems.count);
            }else {
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *_imageItems.count , _scrollView.frame.size.height);
            }
            //交易信息
            for (int i =0; i<_imageItems.count; i++) {
                SGFocusImageItem *item =_imageItems[i];
                
                ZXLabel * label = nil;
                if (_isVertical) {
                    label = [[ZXLabel alloc] initWithFrame:CGRectMake(space, i*_scrollView.frame.size.height+space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                }else{
                    label = [[ZXLabel alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width + space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space)];
                }
                
                label.text = item.title;
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = RGB(67, 67, 67);
                [label adjustFont];
                [_scrollView addSubview:label];
                
                UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
                tapGestureRecognize.delegate = self;
                tapGestureRecognize.numberOfTapsRequired = 1;
                [label addGestureRecognizer:tapGestureRecognize];
                label.userInteractionEnabled = YES;
            }
            
        }
            break;

        case SGFocusOneyText:
        {
            for (int i = 0; i < _imageItems.count; i++) {
                TopicItem *item = [_imageItems objectAtIndex:i];
                TopicItem *topicItem = nil;
              
//                UILabel *labelView = nil;
                NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"TopicItem" owner:nil options:nil];
                if (views.count > 0) {
                    topicItem = views[0];
                }
                
                if (_isVertical) {
                    topicItem.frame = CGRectMake(space, i * _scrollView.frame.size.height + space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space);
                }else {
                    topicItem.frame = CGRectMake(i * _scrollView.frame.size.width + space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space);
                }
                
                [topicItem setType:item.type content:item.content index:item.index];
                
                [_scrollView addSubview:topicItem];
                
                UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
                tapGestureRecognize.delegate = self;
                tapGestureRecognize.numberOfTapsRequired = 1;
                [topicItem addGestureRecognizer:tapGestureRecognize];
                topicItem.userInteractionEnabled = YES;
                
            }
            
            if (_isVertical) {
                
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height*_imageItems.count);
            }else {
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *_imageItems.count , _scrollView.frame.size.height);
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
    if ([_imageItems count]>1)
    {
        if (_isVertical) {
            [_scrollView setContentOffset:CGPointMake(0, ITEM_HEIGHT) animated:NO] ;
        }else {
            [_scrollView setContentOffset:CGPointMake(ITEM_WIDTH, 0) animated:NO] ;
            
        }
        
        if (_isAutoPlay) {
            
            self.scrollInterval = 0;
            if (focusImageType == SGFocusOneyTradeText || focusImageType == SGFocusNews) {
                self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(switchFocusImageItems:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"loopTime", nil] repeats:YES];
            }else{
                
                self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:SWITCH_FOCUS_PICTURE_INTERVAL target:self selector:@selector(switchFocusImageItems:) userInfo:nil repeats:YES];
            }
         
        }
    }
}


/**
 更新frame

 @param frame scrollView的frame
 @param focusImageType 显示的类型(目前仅支持 SGFocusOnlyImageAndPageControl, SGFocusOnlyImage)
 */
- (void)updateFrame:(CGRect)frame focusImageType:(SGFocusImageType )focusImageType
{
    _scrollView.frame = frame;
    float space = 0;
    
    switch (focusImageType) {
        case SGFocusOnlyImageAndPageControl:
        {
            _pageControl.frame = CGRectMake(0, frame.size.height -16-10, CGRectGetWidth(frame), 10);
            
            for (int i = 0; i < _imageItems.count; i++) {
                UIView *view = [_scrollView viewWithTag:i + 10];
                view.frame = CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space);
                if ([view isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)view;
                    imageView.contentMode = UIViewContentModeScaleToFill;
                }
            }
            
            _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageItems.count, _scrollView.frame.size.height);
            
        }
            break;
        case SGFocusOnlyImage:
        {
            for (int i = 0; i < _imageItems.count; i++) {
                UIView *view = [_scrollView viewWithTag:i + 10];
                view.frame = CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space);
                if ([view isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)view;
                    imageView.contentMode = UIViewContentModeScaleToFill;
                }
            }
        }
            break;
        default:
            break;
    }

}

#pragma mark - private methods
- (void)setupViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    float space = 0;
    float buttomSpace = 0;
    if (_focusImageType == SGFocusOnlyImageAndPageControl) {
        buttomSpace = 20;
    }
    
    CGSize size = CGSizeMake(320, 0);

    _pageControl.hidden = NO;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height -16, CGRectGetWidth(self.bounds), 10)];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPageIndicatorTintColor = RGB(204, 0, 0);
    _pageControl.pageIndicatorTintColor = RGB(188, 188, 188);
    _pageControl.hidesForSinglePage = YES;
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
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageItems.count, _scrollView.frame.size.height);
    
    for (int i = 0; i < _imageItems.count; i++) {
        SGFocusImageItem *item = [_imageItems objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space-size.height - buttomSpace)];
        
        if (_focusImageType == SGFocusUIImageType) {
            imageView.image = item.image;
        }else{
            
            [CommonUtil setSDWebImageProperties];
            [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //修改视图模式
                imageView.contentMode = self.imageType;
            }];
        }
        
        [imageView setClipsToBounds:YES];
        [_scrollView addSubview:imageView];
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
    
    int loopTime = 0;
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:timer.userInfo];
    if ([dic.allKeys containsObject:@"loopTime"]) {
        loopTime = [dic[@"loopTime"] intValue];
    }else{
        loopTime = SWITCH_FOCUS_PICTURE_INTERVAL;
    }
    
    if (self.scrollInterval < loopTime) {
        return;
    }
    
    if (_isVertical) {
        CGFloat targetY = _scrollView.contentOffset.y + _scrollView.frame.size.height;
        
        targetY = (int)(targetY/ITEM_HEIGHT) * ITEM_HEIGHT;
        [self moveToTargetPositionY:targetY];
    }else {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        
        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        [self moveToTargetPositionX:targetX];
    }


    
    self.scrollInterval = 0;
}


- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    
    int page;
    if (_isVertical) {
        page = (int)(_scrollView.contentOffset.y / _scrollView.frame.size.height);
    }else {
        page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    }
    if (page > -1 && page < _imageItems.count) {
        SGFocusImageItem *item = [_imageItems objectAtIndex:page];
        if (self.delegate && [self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
        }
        
    }
}

#pragma mark ----- 纵向移动 -----------

- (void)moveToTargetPositionY:(CGFloat)targetY
{
    BOOL animated = YES;
    [_scrollView setContentOffset:CGPointMake(0, targetY) animated:animated];
}

#pragma mark ----- 横向移动 -----------
- (void)moveToTargetPositionX:(CGFloat)targetX
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
        
        if (_isVertical) {
            float targetY = scrollView.contentOffset.y;
            
            if (targetY >= ITEM_HEIGHT * ([_imageItems count] -1)) {
                targetY = ITEM_HEIGHT;
                [_scrollView setContentOffset:CGPointMake(0, targetY) animated:NO];
            }
            else if(targetY <= 0)
            {
                targetY = ITEM_HEIGHT *([_imageItems count]-2);
                [_scrollView setContentOffset:CGPointMake(0, targetY) animated:NO];
            }
        }else {
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
//        NSLog(@"%@",[self.delegate class]);
//        if (self.delegate && [self.delegate respondsToSelector:@selector(foucusImageFrame:currentItem:)])
//        {
//            [self.delegate foucusImageFrame:self currentItem:(int)page];
//        }
    }
    _pageControl.currentPage = page;
    
    self.scrollInterval = 0;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        if (_isVertical) {
            CGFloat targetY = _scrollView.contentOffset.y + _scrollView.frame.size.height;
            
            targetY = (int)(targetY/ITEM_HEIGHT) * ITEM_HEIGHT;
            [self moveToTargetPositionY:targetY];
        }else {
            CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
            targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
            [self moveToTargetPositionX:targetX];
        }
    }
}

/**
 滚动到第几个位置
 
 @param aIndex 位置下标
 */
- (void)scrollToIndex:(int)aIndex
{
    if ([_imageItems count]>1)
    {
        if (aIndex >= ([_imageItems count]-2))
        {
            aIndex = (int)[_imageItems count]-3;
        }
        if (_isVertical) {
            [self moveToTargetPositionY:ITEM_HEIGHT*(aIndex+1)];
            
        }else {
            [self moveToTargetPositionX:ITEM_WIDTH*(aIndex+1)];
            
        }
    }else  {
        if (_isVertical) {
            [self moveToTargetPositionY:0];
            
        }else {
            [self moveToTargetPositionX:0];
            
        }
    }
    [self scrollViewDidScroll:_scrollView];
}

@end

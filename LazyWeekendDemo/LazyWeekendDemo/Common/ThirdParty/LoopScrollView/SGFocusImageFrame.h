//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//
typedef enum {
    SGFocusOneyText, // 文字
    SGFocusOneyImage, // 图片
    SGFocusOneyImageAndPageControl, // 图片 + 底部的点
    SGFocusUIImageType, // UIImage 类型
    SGFocusOneyTradeText, // 交易信息
    SGFocusNews // 新闻类型
} SGFocusImageType;

#import <UIKit/UIKit.h>
@class SGFocusImageItem;
@class SGFocusImageFrame;
@class ScheduleModelView;

#pragma mark - SGFocusImageFrameDelegate
@protocol SGFocusImageFrameDelegate <NSObject>
@optional
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item;
- (void)foucusImageFrame2:(SGFocusImageFrame *)imageFrame didSelectItem:(ScheduleModelView *)item;
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;

@end


@interface SGFocusImageFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
    int _focusImageType;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType )focusImageType andWithisVertical:(BOOL )isVertical;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType)focusImageType;
- (void)scrollToIndex:(int)aIndex;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto imageType:(NSString*)type;

@property (nonatomic, assign) id<SGFocusImageFrameDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *autoScrollTimer;

@property(nonatomic,strong) NSString * imageType;//展示类型

@end

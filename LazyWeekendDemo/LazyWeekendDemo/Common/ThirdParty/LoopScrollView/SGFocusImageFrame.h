//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//
typedef enum {
    SGFocusOneyText, // 文字
    SGFocusOnlyImage, // 图片
    SGFocusOnlyImageAndPageControl, // 图片 + 底部的点
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
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType )focusImageType andWithisVertical:(BOOL )isVertical;

/**
 初始化页面
 
 @param frame frame
 @param delegate 代理
 @param items 展示内容(数组)
 @param isAuto 是否自动滚动
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;

/**
 初始化页面
 
 @param frame frame
 @param delegate 代理
 @param items 展示内容(数组)
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items;

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
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto focusImageType:(SGFocusImageType)focusImageType imageType:(UIViewContentMode)type;


/**
 滚动到第几个位置

 @param aIndex 位置下标
 */
- (void)scrollToIndex:(int)aIndex;


/**
 初始化页面
 
 @param frame frame
 @param delegate 代理
 @param items 展示的内容(数组)
 @param isAuto 是否自动滚动
 @param type 图片的展示类型(宽高自适应, 拉伸等)
 @return
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto imageType:(UIViewContentMode)type;

/**
 更新frame
 
 @param frame scrollView的frame
 @param focusImageType 显示的类型(目前仅支持 SGFocusOnlyImageAndPageControl, SGFocusOnlyImage)
 */
- (void)updateFrame:(CGRect)frame focusImageType:(SGFocusImageType )focusImageType;

@end

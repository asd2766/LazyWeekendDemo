//
//  DSLoopDbImageFrame.h
//  wedding
//
//  Created by Jianyong Duan on 14/12/12.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGFocusImageItem;
@class DSLoopDbImageFrame;

#pragma mark - DSLoopDbImageFrameDelegate
@protocol DSLoopDbImageFrameDelegate <NSObject>

@optional
- (void)foucusImageFrame:(DSLoopDbImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item;
- (void)foucusImageFrame:(DSLoopDbImageFrame *)imageFrame currentItem:(int)index;

@end

@interface DSLoopDbImageFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
    int _displayType;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;
- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items;

- (id)initWithFrame:(CGRect)frame delegate:(id<DSLoopDbImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto displayType:(int)displayType;
- (void)scrollToIndex:(int)aIndex;

@property (nonatomic, assign) id<DSLoopDbImageFrameDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

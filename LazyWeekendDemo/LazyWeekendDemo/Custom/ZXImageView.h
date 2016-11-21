//
//  ZXImageView.h
//  zhaoxiewang
//
//  Created by 吴筠秋 on 15/11/17.
//  Copyright © 2015年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXImageView : UIImageView

@property (strong, nonatomic) NSString *type;//1:已选择图片， 2:上传过图片，但是没有选择新图片 其他：未选择图片

@end

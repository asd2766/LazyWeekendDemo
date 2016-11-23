
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, retain)  NSString     *title;
@property (nonatomic, retain)  NSString     *imageUrl;
@property (nonatomic, retain)  NSString     *type;
@property (nonatomic, assign)  NSInteger     tag;
@property (nonatomic, retain)  NSString     *price;
@property (nonatomic, assign)  NSNumber     *productid;
@property (nonatomic, strong)  NSString     *linkStr;
@property (nonatomic, strong)  NSString     *section;
@property (nonatomic, strong)  UIImage      *image;
@property (nonatomic, strong)  NSString     *param;
@property (nonatomic, strong)  NSString     *fowardStyle;
@property (nonatomic, copy)    NSString     *forwardUrl;


- (id)initWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl tag:(NSInteger)tag;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;

- (id)initWithImage:(UIImage *)image tag:(NSInteger)tag;
@end

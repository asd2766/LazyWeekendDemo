//
//  UIImage+animatedImageWithGIF.m
//
//  Created by YuAo on 2/24/12.
//  Copyright (c) 2012 eico design. All rights reserved.
//

#import "UIImageView+imageViewWithGIF.h"
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
    #define toCF (__bridge CFTypeRef)
    #define ARCCompatibleAutorelease(object) object
#else
    #define toCF (CFTypeRef)
    #define ARCCompatibleAutorelease(object) [object autorelease]
#endif

@implementation UIImageView(animatedImageViewWithGIF)

- (UIImageView *)imageViewWithAnimatedGIFImageSource:(CGImageSourceRef) source
                                         andDuration:(NSTimeInterval) duration WithCenter:(CGPoint)center {
    if (!source) return nil;
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage)
            return nil;
        [images addObject:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
    }
//    UIImageView *imageView = [[UIImageView alloc] init];
    self.center = center;
    [self setAnimationImages:images];
    [self setAnimationDuration:duration];
//    [self sizeToFit];
    [self startAnimating];
    return ARCCompatibleAutorelease(self);
}

-(NSTimeInterval)durationForGifData:(NSData *)data {
    char graphicControlExtensionStartBytes[] = {0x21,0xF9,0x04};
    double duration=0;
    NSRange dataSearchLeftRange = NSMakeRange(0, data.length);
    while(YES){
        NSRange frameDescriptorRange = [data rangeOfData:[NSData dataWithBytes:graphicControlExtensionStartBytes 
                                                                        length:3] 
                                                 options:NSDataSearchBackwards
                                                   range:dataSearchLeftRange];
        if(frameDescriptorRange.location!=NSNotFound){
            NSData *durationData = [data subdataWithRange:NSMakeRange(frameDescriptorRange.location+4, 2)];
            unsigned char buffer[2];
            [durationData getBytes:buffer];
            double delay = (buffer[0] | buffer[1] << 8);
            duration += delay;
            dataSearchLeftRange = NSMakeRange(0, frameDescriptorRange.location);
        }else{
            break;
        }
    }
    return duration/100;
}

- (UIImageView *)imageViewWithGIFData:(NSData *)data WithCenter:(CGPoint)center{
    NSTimeInterval duration = [self durationForGifData:data];
    CGImageSourceRef source = CGImageSourceCreateWithData(toCF data, NULL);
    UIImageView *imageView = [self imageViewWithAnimatedGIFImageSource:source andDuration:duration WithCenter:center];
    CFRelease(source);
    return imageView;
}

- (UIImageView *)imageViewWithGIFURL:(NSURL *)url WithCenter:(CGPoint)center{
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [self imageViewWithGIFData:data WithCenter:center];
}

@end

//
//  UIPlaceHolderTextView.m
//  BabyPhoto
//
//  Created by ITS 段建勇 on 11-11-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation UIPlaceHolderTextView

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:RGB(215, 215, 215)];
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(textChanged:) 
												 name:UITextViewTextDidChangeNotification 
											   object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[self setPlaceholder:@""];
        [self setPlaceholderColor:RGB(215, 215, 215)];
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(textChanged:)
													 name:UITextViewTextDidChangeNotification
												   object:nil];
    }
    return self;
}

- (void)setNewPlaceholder:(NSString *)newPlaceholder{
    self.placeholder = newPlaceholder;
    placeHolderLabel.text = self.placeholder;
}


- (void)setNewPlaceholderColor:(UIColor *)color{
    placeHolderLabel.textColor = color;
}

- (void)textChanged:(NSNotification *)notification {
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
            
        }
		
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
	
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    
    [super drawRect:rect];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	placeHolderLabel = nil;
	placeholderColor = nil;
	placeholder = nil;
}

@end

#import "CBBezier.h"
#import <UIColor-HexUtils/UIColor+HexUtils.h>

@implementation CBBezier

#pragma mark - UIButton Overrides

+ (CBBezier *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [self setNeedsDisplay];
    [super setHighlighted:highlighted];
}

#pragma mark - Touch event overrides


- (void)drawRect:(CGRect)rect
{
    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Color Declarations
    UIColor *borderColor = [UIColor colorWithRed:231.0f/255.0f green:227.0f/255.0f blue:0.0f/255.0f alpha:1.0];// [UIColor colorWithRed:0.77f green:0.43f blue:0.00f alpha:1.00f];
    UIColor *topColor = [UIColor colorWithRed:251.0f/255.0f green:251.0f/255.0f blue:147.0f/255.0f alpha:1.0];// [UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f];
    //UIColor *topColor = [UIColor colorWithHex: @"#FFFF7F"];

    //UIColor *bottomColor = [UIColor colorWithRed:255.0f/255.0f green:241.0f/255.0f blue:0.0f/255.0f alpha:1.0];//[UIColor colorWithRed:0.91f green:0.55f blue:0.00f alpha:1.00f];
    UIColor *bottomColor = [UIColor colorWithHex: @"#FAFE6C"];
    
    UIColor *innerGlow = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // Gradient Declarations
    NSArray *gradientColors = (@[
                                 (id)topColor.CGColor,
                                 (id)bottomColor.CGColor
                                 ]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(gradientColors), NULL);
    
    NSArray *highlightedGradientColors = (@[
                                            (id)bottomColor.CGColor,
                                            (id)topColor.CGColor
                                            ]);
    
    CGGradientRef highlightedGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(highlightedGradientColors), NULL);
    
    
    CGRect frame = self.bounds;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    // Draw rounded rectangle bezier path
    //UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 280, 37) cornerRadius: 5];
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: frame cornerRadius: 5];
    // Use the bezier as a clipping path
    [roundedRectanglePath addClip];
    
    // Use one of the two gradients depending on the state of the button
    CGGradientRef background = self.highlighted? highlightedGradient : gradient;
    
    // Draw gradient within the path
    //CGContextDrawLinearGradient(context, background, CGPointMake(140, 0), CGPointMake(140, 37), 0);
    CGContextDrawLinearGradient(context, background, CGPointMake((w/2), 0), CGPointMake((w/2), h), 0);

    // Draw border
    [borderColor setStroke];
    roundedRectanglePath.lineWidth = 2;
    [roundedRectanglePath stroke];
    
    // Draw Inner Glow
    //UIBezierPath *innerGlowRect = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1.5, 1.5, 277, 34) cornerRadius: 4];
    UIBezierPath *innerGlowRect = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1.5, 1.5, (w - (1.5*2)), (h-(1.5*2))) cornerRadius: 4];
    [innerGlow setStroke];
    innerGlowRect.lineWidth = 1;
    [innerGlowRect stroke];
    
    // Cleanup
    CGGradientRelease(gradient);
    CGGradientRelease(highlightedGradient);
    CGColorSpaceRelease(colorSpace);
}

@end


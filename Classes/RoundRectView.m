#import "RoundRectView.h"


@implementation RoundRectView

- (void)drawRect:(CGRect)rect {
	float radius = 10;
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextBeginPath(context);

	CGContextSetLineWidth(context, 4.0);

	CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);

	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
	CGContextClosePath(context);

	CGContextStrokePath(context);
}


- (void)dealloc {
	[super dealloc];
}

@end
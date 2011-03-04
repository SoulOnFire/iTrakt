#import "Checkbox.h"
#import <QuartzCore/QuartzCore.h>

@interface CheckboxDrawing : CALayer

@end

static void
addRoundedRect(CGContextRef ctx, CGRect rect, float cornerRadius) {
  float x_left = rect.origin.x;
  float x_left_center = x_left + cornerRadius;
  float x_right_center = x_left + rect.size.width - cornerRadius;
  float x_right = x_left + rect.size.width;
  float y_top = rect.origin.y;
  float y_top_center = y_top + cornerRadius;
  float y_bottom_center = y_top + rect.size.height - cornerRadius;
  float y_bottom = y_top + rect.size.height;
  /* Begin path */
  CGContextBeginPath(ctx);
  CGContextMoveToPoint(ctx, x_left, y_top_center);
  /* First corner */
  CGContextAddArcToPoint(ctx, x_left, y_top, x_left_center, y_top, cornerRadius);
  /* Second corner */
  CGContextAddArcToPoint(ctx, x_right, y_top, x_right, y_top_center, cornerRadius);
  /* Third corner */
  CGContextAddArcToPoint(ctx, x_right, y_bottom, x_right_center, y_bottom, cornerRadius);
  /* Fourth corner */
  CGContextAddArcToPoint(ctx, x_left, y_bottom, x_left, y_bottom_center, cornerRadius);
  /* Done */
  CGContextClosePath(ctx);
}

@implementation CheckboxDrawing

- (void)drawInContext:(CGContextRef)context {
  //CGContextSetRGBStrokeColor(context, 0.53, 0.53, 0.53, 1);
  CGContextSetRGBStrokeColor(context, 0.25, 0.25, 0.25, 1);

  CGContextSetLineWidth(context, 1.5);
  addRoundedRect(context, CGRectInset(self.bounds, 2, 2), 3);
  CGContextStrokePath(context);

  CGContextSaveGState(context);
  CGContextSetBlendMode(context, kCGBlendModeClear);
  CGContextMoveToPoint(   context, 16, 2);
  CGContextAddLineToPoint(context, 20, 1);
  CGContextAddLineToPoint(context, 20, 4);
  CGContextAddLineToPoint(context, 17, 7);
  CGContextAddLineToPoint(context, 16, 2);
  CGContextFillPath(context);

  CGContextRestoreGState(context);
  CGContextSetRGBFillColor(context, 0.25, 0.25, 0.25, 1);
  CGContextSetLineWidth(context, 1);
  CGContextMoveToPoint(context, 7, 8);
  CGContextAddLineToPoint(context, 10, 11);
  CGContextAddLineToPoint(context, 19, 1);
  CGContextAddLineToPoint(context, 20, 2);
  CGContextAddLineToPoint(context, 10, 16);
  //CGContextAddLineToPoint(context, 10, 14);
  CGContextAddLineToPoint(context, 5.5, 9.5);
  CGContextAddLineToPoint(context, 7, 8);

  CGContextFillPath(context);
}

@end

@implementation Checkbox

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    NSLog(@"Complete frame %@", NSStringFromCGRect(frame));
    
    CALayer *layer = self.layer;
    
    CAGradientLayer *boxBackground = [CAGradientLayer layer];
    UIColor *startColor  = [UIColor colorWithWhite:0.89 alpha:1.0];
    UIColor *endColor    = [UIColor colorWithWhite:0.83 alpha:1.0];
    boxBackground.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    //boxBackground.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0], nil];
    boxBackground.cornerRadius = 3.0;
    //boxBackground.frame = CGRectMake(2, 2, frame.size.width - 2, frame.size.height - 2);
    boxBackground.frame = CGRectMake(2, 2, 17, 17);
    boxBackground.edgeAntialiasingMask = 0;
    NSLog(@"BG edge antialias: %d BG frame: %@", boxBackground.edgeAntialiasingMask, NSStringFromCGRect(boxBackground.frame));
    [layer addSublayer:boxBackground];

    CALayer *drawing = [CheckboxDrawing layer];
    //drawing.frame = CGRectMake(2, 2, frame.size.width - 2, frame.size.height - 2);
    //drawing.frame = CGRectMake(2, 2, 26, 26);
    drawing.frame = CGRectMake(0, 0, 21, 21);
    [layer addSublayer:drawing];
    [drawing setNeedsDisplay];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

//- (void)dealloc {
  //[super dealloc];
//}


@end

#import "NumberKeypadModController.h"


@interface NumberKeypadModController (PrivateMethods)
- (void) addDoneToKeyboard;
- (void) removeDoneFromKeyboard;
- (void) donePressed;
@end


#define PRE_SLIDING_DELAY_DURATION		0.1
#define SLIDE_IN_ANIMATION_DURATION	0.2
#define SLIDE_OUT_ANIMATION_DURATION	0.15

#define USE_TEXTURED_BUTTON		0


@implementation NumberKeypadModController

@synthesize fixKeyboardTimer;

@synthesize doneButton;
@synthesize currentTextField;

@synthesize delegate;


- (id)init {
	if (self == [super init]) {
		self.fixKeyboardTimer = nil;
#if (USE_TEXTURED_BUTTON != 0)
		self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.frame = CGRectMake(0, 480, 105, 53);
		if ([[[UIDevice currentDevice] systemVersion] hasPrefix:@"3"]) {
			doneButton.frame = CGRectMake(0, 480, 105, 53);
			[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
			[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
		} else {        
			[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
			[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
		}
#else
		self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.frame = CGRectMake(0, 480, 105, 53);
		if ([[[UIDevice currentDevice] systemVersion] hasPrefix:@"3"])
			doneButton.frame = CGRectMake(0, 480, 105, 53);
		doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
		[doneButton setTitleColor:[UIColor colorWithRed:60.0f/255.0f green:64.0f/255.0f blue:73.0f/255.0f alpha:1.0] forState:UIControlStateNormal];	
		[doneButton setBackgroundImage:[UIImage imageNamed:@"doneKeyDownBackground.png"] forState:UIControlStateHighlighted];
		[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[doneButton setTitle:@"DONE" forState:UIControlStateNormal];
#endif

		[doneButton addTarget:self action:@selector(donePressed) forControlEvents:UIControlEventTouchUpInside];

		self.currentTextField = nil;
		self.delegate = nil;

		showHideCounter = 0;
		doneButtonShown = NO;
	}
	return self;
}


- (void)textFieldShouldBeginEditing:(UITextField *)textField {
	if (textField.keyboardType != UIKeyboardTypeNumberPad)
	{
		doneButton.hidden = YES;
		doneButtonShownRecently = YES;
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {	 
	if (textField.keyboardType != UIKeyboardTypeNumberPad)
		return;

//	NSLog(@"textFieldDidBeginEditing");
	self.currentTextField = textField; //Save reference to current textfield being edited	

	if (!doneButtonShownRecently)
	{
		if (fixKeyboardTimer)
			[fixKeyboardTimer invalidate];
		self.fixKeyboardTimer = [NSTimer timerWithTimeInterval:PRE_SLIDING_DELAY_DURATION target:self
													 selector:@selector(addDoneToKeyboard) userInfo:nil repeats:NO];
		[[NSRunLoop currentRunLoop] addTimer:fixKeyboardTimer forMode:NSDefaultRunLoopMode];
	} else
	{
		[doneButton removeFromSuperview];
		[self addDoneToKeyboard];
	}
}

- (void)textFieldShouldEndEditing:(UITextField *)textField {
	if (textField.keyboardType != UIKeyboardTypeNumberPad)
	{
		doneButtonShownRecently = YES;
		[self performSelector:@selector(considerDoneButtonReallyHidden) withObject:nil afterDelay:SLIDE_OUT_ANIMATION_DURATION];
		return;
	}
	[self removeDoneFromKeyboard];
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
}

- (void)resignedResponderWithView:(UIView*)textField {
//	NSLog(@"resignedResponderWithView");
	[self removeDoneFromKeyboard];
}

- (void) addDoneToKeyboard {
//	NSLog(@"addDoneToKeyboard");

	doneButton.hidden =  NO;

	//Add a button to the top, above all windows
	NSArray *allWindows = [[UIApplication sharedApplication] windows];
	NSUInteger topWindowIndex = [allWindows count] - 1;
	UIWindow *topWindow = [allWindows objectAtIndex:topWindowIndex];

	// check if top window is of keypad or else
	NSString *topViewClassName = [NSString stringWithFormat:@"%@", [topWindow class]];
	while (![topViewClassName isEqualToString:@"UITextEffectsWindow"] ) {
		--topWindowIndex;
		
		if(topWindowIndex < 0)
			break;
		
		topWindow = [allWindows objectAtIndex:topWindowIndex];
		topViewClassName = [NSString stringWithFormat:@"%@", [topWindow class]];
	}
	
	if(topWindowIndex < 0) {
		topWindowIndex = [allWindows count] - 1;
		topWindow = [allWindows objectAtIndex:topWindowIndex];
	}
	
	if (doneButton.superview)
		[doneButton removeFromSuperview];

	[topWindow addSubview:doneButton];

	if (!doneButtonShownRecently) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:SLIDE_IN_ANIMATION_DURATION];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		doneButton.frame = CGRectMake(0, 480-53, doneButton.frame.size.width, 53);
		[UIView commitAnimations];
	} else {
		doneButton.frame = CGRectMake(0, 427, doneButton.frame.size.width, 53);
	}

	doneButtonShown = YES;
}

- (void) removeDoneFromKeyboard {
//	NSLog(@"removeDoneFromKeyboard");

	[fixKeyboardTimer invalidate];
	self.fixKeyboardTimer = nil;

	if (!doneButtonShownRecently) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:SLIDE_OUT_ANIMATION_DURATION];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		doneButton.frame = CGRectMake(0, 480, doneButton.frame.size.width, 53);
		[UIView commitAnimations];
	} else {
		doneButton.frame = CGRectMake(0, 480, doneButton.frame.size.width, 53);
	}

	doneButtonShown = NO;
	doneButtonShownRecently = YES;
	[self performSelector:@selector(considerDoneButtonReallyHidden) withObject:nil afterDelay:SLIDE_OUT_ANIMATION_DURATION];
}

- (void)considerDoneButtonReallyHidden {
//	NSLog(@"considerDoneButtonReallyHidden");
	doneButtonShownRecently = NO;
}

- (void) donePressed {
	[self.currentTextField resignFirstResponder];
	if ([delegate respondsToSelector:@selector(donePressed:)])
		[delegate performSelector:@selector(donePressed:) withObject:self.currentTextField];
}

- (void) dealloc {
	[fixKeyboardTimer release];
	[doneButton removeFromSuperview];
	[doneButton release];
	[delegate release];
	[super dealloc];
}

@end
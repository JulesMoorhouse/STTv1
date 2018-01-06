#import <Foundation/Foundation.h>


@protocol NumberKeypadModControllerDelegate <NSObject>

- (void) donePressed:(id)sender;

@end


/**
 *	The class used to create the keypad
 */
@interface NumberKeypadModController : NSObject
{
	NSTimer *fixKeyboardTimer;
	UIButton *doneButton;
	UITextField *currentTextField;
	id<NumberKeypadModControllerDelegate> delegate;
	NSInteger		showHideCounter;
	BOOL	doneButtonShown;
	BOOL	doneButtonShownRecently;
}

@property (nonatomic, strong) NSTimer *fixKeyboardTimer;

@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UITextField *currentTextField;

@property (nonatomic, strong) id<NumberKeypadModControllerDelegate> delegate;


- (void)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldShouldEndEditing:(UITextField *)textField;

- (void)resignedResponderWithView:(UIView*)textField;


@end


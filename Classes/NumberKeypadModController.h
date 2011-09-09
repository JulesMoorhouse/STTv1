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
	int		showHideCounter;
	BOOL	doneButtonShown;
	BOOL	doneButtonShownRecently;
}

@property (nonatomic, retain) NSTimer *fixKeyboardTimer;

@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) UITextField *currentTextField;

@property (nonatomic, retain) id<NumberKeypadModControllerDelegate> delegate;


- (void)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldShouldEndEditing:(UITextField *)textField;

- (void)resignedResponderWithView:(UIView*)textField;


@end


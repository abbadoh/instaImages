//
//  IIBaseViewController.h
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIError.h"

@interface IIBaseViewController : UIViewController

- (void)createToastWithText:(NSString*)text;
- (void)createErrorMessageWithError:(IIError*)error;

@end

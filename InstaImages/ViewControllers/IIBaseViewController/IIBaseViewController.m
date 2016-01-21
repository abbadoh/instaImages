//
//  IIBaseViewController.m
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIBaseViewController.h"


@implementation IIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createToastWithText:(NSString*)text {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:text message:nil delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)createErrorMessageWithError:(IIError*)error {
    [self createToastWithText:error.errorMessage];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

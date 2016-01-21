//
//  IIAuthViewController.m
//  InstaImages
//
//  Created by Gumo on 15/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "SimpleAuth.h"
#import "IIModelManager.h"
#import "IIAutocompleteManager.h"
#import "IIUserDefaultsManager.h"
#import "IIAuthViewController.h"
#import "IIGalleryViewController.h"
#import "HTAutocompleteTextField.h"

@interface IIAuthViewController ()
@property (weak, nonatomic) IBOutlet HTAutocompleteTextField *usernameTextField;
@property (strong, nonatomic) NSString * userId;
@end

@implementation IIAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    self.usernameTextField.text = @"";
    self.usernameTextField.autocompleteLabel.text = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [self initAutocompleteUsernameTextField];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initAutocompleteUsernameTextField {
    IIAutocompleteManager * manager = [IIAutocompleteManager sharedManager];
    NSArray * usernames = [IIUserDefaultsManager getAutocompleteArray];
    [manager setAutocompleteArrayOfUsernames:usernames];
    self.usernameTextField.autocompleteDataSource = manager;
    self.usernameTextField.autocompleteDisabled = NO;
}

- (IBAction)onLoginButtonClick:(id)sender {
    [self tryToLogin];
}

- (void)tryToLogin {
    if (![self isUsernameTextFieldEmpty]) {
        self.usernameTextField.autocompleteDisabled = YES;
        [IIUserDefaultsManager saveUsernameToAutocomleteArray:self.usernameTextField.text];
        [self doLogin];
    }
    else {
        [self createToastWithText:@"Username is empty!"];
    }
}

-(BOOL)isUsernameTextFieldEmpty {
    return [self.usernameTextField.text isEqualToString:@""];
}

-(void)doLogin {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[IIModelManager sharedManager] getUserIdForUserWithUsername:self.usernameTextField.text completion:^(NSString *userId, IIError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (userId) {
            self.userId = userId;
            [self performSegueWithIdentifier:@"toGalleryViewController" sender:self];
        }
        else if (error) {
            [self createErrorMessageWithError:error];
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self tryToLogin];
    return NO;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[IIGalleryViewController class]]) {
        ((IIGalleryViewController*)segue.destinationViewController).userId = self.userId;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

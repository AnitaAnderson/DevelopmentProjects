//
//  LoginViewController.h
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
//@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;

- (IBAction)performLogin:(id)sender;

@end

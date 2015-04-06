//
//  LoginViewController.m
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize userName, password, emailAddress;


- (void)viewDidLoad {
    [super viewDidLoad];
    
   }

-(void)viewDidAppear:(BOOL)animated {
    //check if user logged on recently - if so prepare for segue
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self performSegueWithIdentifier:@"registerInventorySegue" sender:self];
        NSLog(@"user recently logged in...");
        
        return;
    }
    
    // Do any additional setup after loading the view.
    userName.delegate = self;
    password.delegate = self;
    emailAddress.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - login
- (IBAction)performLogin:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.userName.text;
    user.password = self.password.text;
    user.email = self.emailAddress.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            //continue
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(errorString);
        }
    }];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

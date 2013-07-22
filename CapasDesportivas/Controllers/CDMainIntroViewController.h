//
//  CDMainIntroViewController.h
//  SportsCovers
//
//  Created by Developer on 7/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDMainIntroViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

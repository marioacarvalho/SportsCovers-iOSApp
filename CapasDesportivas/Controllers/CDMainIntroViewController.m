//
//  CDMainIntroViewController.m
//  SportsCovers
//
//  Created by Developer on 7/21/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "CDMainIntroViewController.h"
@interface CDMainIntroViewController ()
{
    MBProgressHUD *hud;
}
@end

@implementation CDMainIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    NSDictionary *dic = @{@"Email": _emailTextField.text,
                          @"Password": _passwordTextField.text};
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Registering...";
    [CDServer sharedInstance].progressIndicator = hud;
    [[CDServer sharedInstance] createNewUser:dic
                                 andOnFinish:^(NSDictionary *finish) {
                                     XLog(@"%@", finish);
                                     [hud hide:YES];
                                     if ([finish objectForKey:@"Error"]) {
                                         handleErrorWith(finish);
                                         return;
                                     }
                                     saveUserInformation(finish);
                                     [self getAllDataAndProsegue];
                                     
        
    }];
}

- (IBAction)loginAction:(id)sender {
    NSDictionary *dic = @{@"Email": _emailTextField.text,
                          @"Password": _passwordTextField.text};
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    [CDServer sharedInstance].progressIndicator = hud;
    [[CDServer sharedInstance] logInUser:dic
                                 andOnFinish:^(NSDictionary *finish) {
                                     XLog(@"%@", finish);
                                     [hud hide:YES];
                                     if ([finish objectForKey:@"Error"]) {
                                         handleErrorWith(finish);
                                         return;
                                     }
                                     saveUserInformation(finish);
                                     [self getAllDataAndProsegue];
                                 }];
}

- (void)getAllDataAndProsegue
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading all information";
    [CDServer sharedInstance].progressIndicator = hud;
    [[CDServer sharedInstance] getAllDataAndOnFinish:^(BOOL finish) {
        if (finish) {
            [hud hide:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginComplete object:nil];
            
        } else {
            handleErrorWith(nil);
        }
    }];
}


@end

//
//  TechLoginViewController.m
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "TechLoginViewController.h"

#import "CommonUtils.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface TechLoginViewController () {
    CommonUtils* utils;
}

@end

@implementation TechLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initposition];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    utils = [CommonUtils sharedObject];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *logintech = [prefs stringForKey:@"LoginTech"];
    self.m_techID.text = logintech;
    
    NSString *techType = [prefs stringForKey:@"TechType"];
    self.m_optionTech.selectedSegmentIndex = 0;
    if ([techType isEqualToString:@"Salesman"]) {
        self.m_optionTech.selectedSegmentIndex = 1;
    }

}

- (void)initposition {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.m_optionTech.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_optionTech.frame = rect;
    
    rect = self.m_idLabel.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_idLabel.frame = rect;
    
    rect = self.m_passwordLabel.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_passwordLabel.frame = rect;
    self.m_password.secureTextEntry = YES;
    
    rect = self.m_techID.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_techID.frame = rect;
    
    rect = self.m_password.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_password.frame = rect;
    
    rect = self.m_btnLogin.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_btnLogin.frame = rect;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLogin:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString        *ipAddr = [prefs stringForKey:@"ServerAddress"];
    
    if (self.m_techID.text.length < 1)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please input Tech ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    NSString *tmp = self.m_techID.text;
    NSString *strspace = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *strdash = [strspace stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL valid = [[strdash stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    
    if (!valid)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Only alphanumeric characters and dash can be included in Tech ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    [SVProgressHUD show];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *stCall;
 
    if (self.m_optionTech.selectedSegmentIndex == 0)
        stCall = [NSString stringWithFormat:@"https://%@/api/TechCredential/CheckPassword/%@?pPassword=%@", ipAddr, strspace, self.m_password.text];
    else
        stCall = [NSString stringWithFormat:@"https://%@/api/TechCredential/IsSalesmanValid/%@?pPassword=%@", ipAddr, strspace, self.m_password.text];
    
    
    [manager GET:stCall parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {

        [SVProgressHUD dismiss];
        NSString *companyName = responseObject[1];
        if ( ( self.m_optionTech.selectedSegmentIndex == 0 && ![companyName isEqualToString:@"not found1"] ) || (self.m_optionTech.selectedSegmentIndex == 1 && ![companyName isEqualToString:@"No"]))
        {
            if (self.m_optionTech.selectedSegmentIndex == 0)
                [CommonUtils saveUserData:strspace:self.m_password.text:@"T"];
            else
                [CommonUtils saveUserData:strspace:self.m_password.text:@"S"];
            
            [self performSegueWithIdentifier:@"login2Menu" sender:nil];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Not Found" message:@"Not Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            return;
        }
    
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error:%@", error);
        [SVProgressHUD dismiss];
    }];
    
    //[self performSegueWithIdentifier:@"login2Menu" sender:nil];
    
}

- (IBAction)onSegValueChanged:(id)sender {
    switch (self.m_optionTech.selectedSegmentIndex) {
        case 0:
            self.m_idLabel.text = @"Tech ID";
            self.m_techID.placeholder = @"Enter Tech id...";
            break;
        case 1:
            self.m_idLabel.text = @"Salesman";
            self.m_techID.placeholder = @"Enter Salesman...";
            break;
        default:
            break;
    }
}

#pragma mark - KeyBoard notifications
-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)animationView:(CGFloat)yPos {
    if(yPos == self.view.frame.origin.y)
        return;
    //	self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rt = self.view.frame;
                         rt.origin.y = yPos/* + 64*/;
                         self.view.frame = rt;
                     }completion:^(BOOL finished) {
                         //						 self.view.userInteractionEnabled = YES;
                     }];
}

- (void)keyboardWillShow:(NSNotification*)notify {
    
    [self animationView:-90];
}

- (void)keyboardWillHide:(NSNotification*)notify {
    [self animationView:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.m_techID) {
        [self.m_password becomeFirstResponder];
    }
    else if (textField == self.m_password) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end

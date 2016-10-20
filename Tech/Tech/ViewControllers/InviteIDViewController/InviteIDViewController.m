//
//  InviteIDViewController.m
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "InviteIDViewController.h"
#import "CommonUtils.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

#import "TechLoginViewController.h"

@interface InviteIDViewController () <ComboBoxViewDelegate> {
    CommonUtils* utils;
    BOOL bSaved;
    NSMutableArray *hosts;
    NSMutableArray *option;
    int selectIndex;
    int optionIndex;
}

    @property (weak, nonatomic) IBOutlet ComboBoxView *m_ipAddr;

@end

@implementation InviteIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initposition];
    
    self.m_ipAddr.delegate = self;
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
    
    utils = [CommonUtils sharedObject];
    selectIndex = 0;
    optionIndex = 0;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString        *ipAddr = [prefs stringForKey:@"IPAddress"];
    
    if ( ipAddr != nil )
    {
        [self performSegueWithIdentifier:@"invite2Login" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    hosts = [NSMutableArray arrayWithObjects:@"saimobile", @"saimobile1", @"saimobile2", nil];
    option = [NSMutableArray arrayWithObjects:@"SAWIN", @"Custom", nil];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString        *ipAddr = [prefs stringForKey:@"IPAddress"];
    NSString        *optionString = [prefs stringForKey:@"Option"];
    
    if ([ipAddr isEqualToString:@"saimobile"])
    {
        selectIndex = 0;
        [self.m_ipAddr updateWithSelectedIndex:0];
    }
    else if ([ipAddr isEqualToString:@"saimobile1"])
    {
        selectIndex = 1;
        [self.m_ipAddr updateWithSelectedIndex:1];
    }
    
    else if ([ipAddr isEqualToString:@"saimobile2"])
    {
        selectIndex = 2;
        [self.m_ipAddr updateWithSelectedIndex:2];
    }
    
    if ([optionString isEqualToString:@"SAWIN"])
    {
        optionIndex = 0;
        self.m_serverOption.selectedSegmentIndex = 0;
    }
    else if ([optionString isEqualToString:@"Custom"])
    {
        optionIndex = 1;
        self.m_serverOption.selectedSegmentIndex = 1;
    }
    
    [self.m_ipAddr setTitleColor:[UIColor blackColor]];
    [self.m_ipAddr updateWithAvailableComboBoxItems:hosts];
    [self.m_ipAddr.layer setCornerRadius:5.0];
    [self.m_ipAddr.layer setBorderWidth:1.0];
    [self.m_ipAddr.layer setBorderColor:[[UIColor grayColor] CGColor]];

}

- (void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.m_serverOption.frame;
    
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_serverOption.frame = rect;
    
    rect = self.m_idLabel.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_idLabel.frame = rect;
    
    rect = self.m_ipAddress.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_ipAddress.frame = rect;
    self.m_ipAddress.hidden = YES;
    
    rect = self.m_addrLabel.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_addrLabel.frame = rect;
    
    rect = self.m_inviteID.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_inviteID.frame = rect;
    
    rect = self.m_ipAddr.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_ipAddr.frame = rect;
    
    rect = self.m_btnGo.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_btnGo.frame = rect;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onGo:(id)sender {
    //self.m_ipAddr.text = @"216.15.147.97";
    //self.m_inviteID.text = @"Q7Q872";
    
    [self performSegueWithIdentifier:@"invite2Login" sender:nil];
    
    if (optionIndex == 0)
    {
        [CommonUtils saveLastLogin:hosts[selectIndex]:self.m_inviteID.text:option[optionIndex]];
    }
    else if (optionIndex == 1)
    {
        if (self.m_ipAddress.text.length < 1)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please input IP Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            return;
        }
        [CommonUtils saveLastLogin:self.m_ipAddress.text:self.m_inviteID.text:option[optionIndex]];
    }
}

- (IBAction)onServerOptionChanged:(id)sender {
    if (self.m_serverOption.selectedSegmentIndex == 0)
    {
        self.m_ipAddr.hidden = NO;
        self.m_ipAddress.hidden = YES;
        optionIndex = 0;
    }
    else if (self.m_serverOption.selectedSegmentIndex == 1)
    {
        self.m_ipAddr.hidden = YES;
        self.m_ipAddress.hidden = NO;
        optionIndex = 1;
    }
}


#pragma mark - KeyBoard notifications

- (void)dismissKeyboard {
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
    if (textField == self.m_inviteID) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - ComboBoxViewDelegate Methods

- (void) expandedComboBoxView:(ComboBoxView *)comboBoxView {
    
}

- (void) collapseComboBoxView:(ComboBoxView *)comboBoxView {
    
}

- (void) selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView {
    selectIndex = (int)selectedIndex;

}
@end

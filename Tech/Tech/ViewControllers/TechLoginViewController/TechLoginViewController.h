//
//  TechLoginViewController.h
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TechLoginViewController : UIViewController
- (IBAction)onLogin:(id)sender;
- (IBAction)onSegValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *m_techID;
@property (weak, nonatomic) IBOutlet UITextField *m_password;
@property (weak, nonatomic) IBOutlet UISegmentedControl *m_optionTech;


@property (weak, nonatomic) IBOutlet UILabel *m_idLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_btnLogin;

@property (assign) BOOL bBack;
@end

//
//  InviteIDViewController.h
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBoxView.h"

@interface InviteIDViewController : UIViewController
- (IBAction)onGo:(id)sender;
- (IBAction)onServerOptionChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *m_inviteID;
@property (weak, nonatomic) IBOutlet UITextField *m_ipAddress;

@property (weak, nonatomic) IBOutlet UILabel *m_addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_idLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_btnGo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *m_serverOption;

@property (assign) BOOL bBack;
@end

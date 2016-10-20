//
//  ServiceMenuViewController.h
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceMenuViewController : UIViewController
- (IBAction)onServiceCall:(id)sender;

- (IBAction)onUnappliedDeposit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *m_btnCall;
@property (weak, nonatomic) IBOutlet UIButton *m_btnDeposit;
@end

//
//  ServiceMenuViewController.m
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "ServiceMenuViewController.h"
#import "TechLoginViewController.h"


@interface ServiceMenuViewController () 

@end

@implementation ServiceMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initposition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initposition {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.m_btnCall.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_btnCall.frame = rect;
    
    rect = self.m_btnDeposit.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_btnDeposit.frame = rect;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onServiceCall:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString        *techType = [prefs stringForKey:@"TechType"];
    
    if ([techType isEqualToString:@"S"] )
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Salesman can't use Service Call function." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    [self performSegueWithIdentifier:@"menu2Calls" sender:nil];

}

- (IBAction)onUnappliedDeposit:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString       *arSearch = [prefs stringForKey:@"ARSearch"];
    NSString       *unapplied = [prefs stringForKey:@"CreateUnapplied"];
    
    if ([unapplied isEqualToString:@"1"])
    {
        if ([arSearch isEqualToString:@"1"])
            [self performSegueWithIdentifier:@"menu2AR" sender:nil];
        else
            [self performSegueWithIdentifier:@"menu2Charge" sender:nil];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You don't have permission to Create Unapplied Deposit." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
}
@end

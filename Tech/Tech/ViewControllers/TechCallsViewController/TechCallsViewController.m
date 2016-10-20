//
//  TechCallsViewController.m
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "TechCallsViewController.h"
#import "TechCallsHeaderCell.h"
#import "TechCallListTableViewCell.h"
#import "ChargeCreditCardViewController.h"


#import "CommonUtils.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface TechCallsViewController () {
    NSMutableArray* artCategories;
    NSDictionary* serviceCalls;
    NSString* pBillTo;
    NSString* pAddress;
    NSString* pZipcode;
    NSNumber* pAmount;
}

@end

@implementation TechCallsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString        *loginTech = [prefs stringForKey:@"LoginTech"];
    NSString        *ipAddr = [prefs stringForKey:@"ServerAddress"];
    
    
    [SVProgressHUD show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager setResponseSerializer:responseSerializer];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

//    NSString *techCalls = [NSString stringWithFormat:@"https://%@.com:290/api/TechCalls/TechServiceCalls/%@?pServiceDate=%@", ipAddr, loginTech, [dateFormatter stringFromDate:[NSDate date]]];
    
    NSString *techCalls = [NSString stringWithFormat:@"https://%@/api/TechCalls/TechServiceCalls/%@?pServiceDate=2015/1/29", ipAddr, loginTech];
    
    [manager GET:techCalls parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        artCategories = responseObject;
        [self.m_tableView reloadData];

        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error:%@", error);
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initposition {
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.m_tableView.frame;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height;
    self.m_tableView.frame = rect;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int nNum = (int)[artCategories count];
    
    return (nNum + 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Cell for Row Index");
    UITableViewCell *tableCell;
    
    if (indexPath.row == 0)
    {
        TechCallsHeaderCell* headerCell = (TechCallsHeaderCell*)[self.m_tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        
        tableCell = headerCell;
    }
    else
    {
        TechCallListTableViewCell* detailCell = (TechCallListTableViewCell*)[self.m_tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        
        int nNum = (int)[artCategories count];
        
        if (nNum > 0)
        {
            if (indexPath.row <= nNum)
            {
                NSDictionary* object = [artCategories objectAtIndex:(indexPath.row - 1)];

                detailCell.m_smName.text = [object objectForKey:@"SmName"];
                detailCell.m_smAddress.text = [object objectForKey:@"SmAddress"];
                
                NSNumber *invoiceAmount = [object objectForKey:@"invoiceAmount"];
                NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
                [fmt setPositiveFormat:@"0.00"];
                detailCell.m_invoiceAmount.text = [fmt stringFromNumber:invoiceAmount];
                
                NSString *smCity = [object objectForKey:@"smCity"];
                NSString *smState = [object objectForKey:@"smState"];
                NSString *smZip = [object objectForKey:@"smZip"];
                
                NSString * cat = [NSString stringWithFormat:@"%@,  %@  %@",
                                  smCity, smState, smZip];
                detailCell.m_smCityPhone.text = cat;
                
                detailCell.m_smPhone.text = [NSString stringWithFormat:@"P: %@", [object objectForKey:@"SmPhone"]];
                
                NSString *callNum = [object objectForKey:@"callNum"];
                NSString *st = [object objectForKey:@"serviceType"];
                NSString *tp = [object objectForKey:@"timePromised"];
                
                cat = [NSString stringWithFormat:@"Call# %@  ST: %@  TP: %@", callNum, st, tp];
                detailCell.m_smCallNum.text = cat;
                
                detailCell.m_problemDescription.text = [NSString stringWithFormat:@"PD: %@", [object objectForKey:@"problemDescription"]];
                detailCell.m_specialInstructions.text = [NSString stringWithFormat:@"SI: %@", [object objectForKey:@"specialInstructions"]];
            }
        }
        
        tableCell = detailCell;
    }
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0)
    {
        NSDictionary* object = [artCategories objectAtIndex:(indexPath.row - 1)];
        pBillTo = [object objectForKey:@"billTo"];
        pAmount = [object objectForKey:@"invoiceAmount"];
        pAddress = [object objectForKey:@"SmAddress"];
        pZipcode = [object objectForKey:@"smZip"];
        serviceCalls = object;
        [self performSegueWithIdentifier:@"calls2Charge" sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 0;
    
    if (indexPath.row == 0)
        nHeight = 43;
    else
        nHeight = 107;
    return nHeight;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"calls2Charge"])
    {
        ChargeCreditCardViewController* chargeController = [segue destinationViewController];
        chargeController.pBillTo = pBillTo;
        chargeController.pAmount = pAmount;
        chargeController.pAddress = pAddress;
        chargeController.pZipcode = pZipcode;
        
        chargeController.serviceCalls = serviceCalls;
    }
}
@end

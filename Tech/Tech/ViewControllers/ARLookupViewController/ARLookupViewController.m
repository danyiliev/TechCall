//
//  ARLookupViewController.m
//  Tech
//
//  Created by apple on 3/4/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "ARLookupViewController.h"
#import "ARCallsHeaderCell.h"
#import "ARListViewCell.h"
#import "ChargeAmountViewController.h"

#import "CommonUtils.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface ARLookupViewController () {
    NSMutableArray* artCategories;
    ARCallsHeaderCell* headerCell;
    NSDictionary* category;
}

@end

@implementation ARLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBtnClicked:(UIButton*)sender
{
    if (sender.tag == 0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSString        *loginTech = [prefs stringForKey:@"LoginTech"];
        NSString        *ipAddr = [prefs stringForKey:@"ServerAddress"];
        NSString        *techType = [prefs stringForKey:@"TechType"];
        
        NSMutableArray *fields = [NSMutableArray arrayWithObjects:@"customer_name", @"cust_address1", @"customer_phone", nil];
        NSMutableArray *criterias = [NSMutableArray arrayWithObjects:@"like", @"=", nil];
        
        [SVProgressHUD show];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        [manager setResponseSerializer:responseSerializer];
        
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        
        NSString *techCalls = [NSString stringWithFormat:@"https://%@/api/billTo/%@?pTechorSalesman=%@&pSearchField=%@&pSearchCri=%@&pSearchValue=%@", ipAddr, loginTech, techType, fields[headerCell.m_comboField.getSelectedIndex], criterias[headerCell.m_comboCriteria.getSelectedIndex], headerCell.m_editValue.text];
        
        NSString *replacedURL = [techCalls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSString *techCalls = [NSString stringWithFormat:@"http://216.15.147.97:90/api/TechCalls/TechServiceCalls/%@?pServiceDate=2015/1/29", loginTech];
        
        
        [manager GET:replacedURL parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
            
            [SVProgressHUD dismiss];
            artCategories = responseObject;
            [self.m_tableView reloadData];
            
            
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error:%@", error);
            [SVProgressHUD dismiss];
        }];
    }
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
        headerCell = (ARCallsHeaderCell*)[self.m_tableView dequeueReusableCellWithIdentifier:@"ARHeaderCell"];

        [headerCell.m_comboField updateWithSelectedIndex:0];
        [headerCell.m_comboCriteria updateWithSelectedIndex:0];
        headerCell.m_searchButton.tag = indexPath.row;
        [headerCell.m_searchButton addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        
        tableCell = headerCell;
    }
    else
    {
        ARListViewCell* detailCell = (ARListViewCell*)[self.m_tableView dequeueReusableCellWithIdentifier:@"ARListCell"];
        
        
        int nNum = (int)[artCategories count];
        
        if (nNum > 0)
        {
            if (indexPath.row <= nNum)
            {
                NSDictionary* object = [artCategories objectAtIndex:(indexPath.row - 1)];
                detailCell.m_arName.text = [object objectForKey:@"billToName"];
                detailCell.m_arPhone.text = [NSString stringWithFormat:@"Phone:%@", [object objectForKey:@"billToPhone"]];
                detailCell.m_arAddress.text = [object objectForKey:@"billToAddress1"];
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
        category = [artCategories objectAtIndex:(indexPath.row - 1)];
        [self performSegueWithIdentifier:@"ar2Charge" sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 0;
    
    if (indexPath.row == 0)
        nHeight = 175;
    else
        nHeight = 70;
    return nHeight;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ar2Charge"])
    {
        ChargeAmountViewController* chargeController = [segue destinationViewController];
        chargeController.serviceCalls = category;
    }
}
@end

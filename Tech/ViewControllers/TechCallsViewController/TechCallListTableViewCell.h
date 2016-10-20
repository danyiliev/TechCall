//
//  TechCallListTableViewCell.h
//  Tech
//
//  Created by apple on 1/6/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TechCallListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_smName;
@property (weak, nonatomic) IBOutlet UILabel *m_smAddress;
@property (weak, nonatomic) IBOutlet UILabel *m_smCityPhone;
@property (weak, nonatomic) IBOutlet UILabel *m_smCallNum;
@property (weak, nonatomic) IBOutlet UILabel *m_problemDescription;
@property (weak, nonatomic) IBOutlet UILabel *m_specialInstructions;
@property (weak, nonatomic) IBOutlet UILabel *m_invoiceAmount;
@property (weak, nonatomic) IBOutlet UILabel *m_smPhone;
@end

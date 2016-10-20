//
//  ARCallsHeaderCell.h
//  Tech
//
//  Created by apple on 3/4/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBoxView.h"

@interface ARCallsHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_fieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_criteriaLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_valueLabel;

@property (weak, nonatomic) IBOutlet ComboBoxView *m_comboField;
@property (weak, nonatomic) IBOutlet ComboBoxView *m_comboCriteria;

@property (weak, nonatomic) IBOutlet UITextField *m_editValue;
@property (weak, nonatomic) IBOutlet UIButton *m_searchButton;

@end

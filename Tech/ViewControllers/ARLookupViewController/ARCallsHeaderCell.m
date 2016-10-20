//
//  ARCallsHeaderCell.m
//  Tech
//
//  Created by apple on 3/4/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import "ARCallsHeaderCell.h"
#import "ComboBoxView.h"

@interface ARCallsHeaderCell () <ComboBoxViewDelegate> {
    NSMutableArray *fields;
    NSMutableArray *criterias;
}

@end


@implementation ARCallsHeaderCell

- (void)awakeFromNib {
    // Initialization code
    
    self.m_comboField.delegate = self;
    self.m_comboCriteria.delegate = self;
    
    fields = [NSMutableArray arrayWithObjects:@"Name", @"Address", @"Phone", nil];
    criterias = [NSMutableArray arrayWithObjects:@"Like", @"Equal", nil];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.m_comboField.frame;
    rect.origin.x = screenRect.size.width * 4 / 10;
    rect.size.width = screenRect.size.width * 6 / 10 - 9;
    self.m_comboField.frame = rect;

    rect = self.m_comboCriteria.frame;
    rect.origin.x = screenRect.size.width * 4 / 10;
    rect.size.width = screenRect.size.width * 6 / 10 - 9;
    self.m_comboCriteria.frame = rect;
    
    rect = self.m_editValue.frame;
    rect.origin.x = screenRect.size.width * 4 / 10;
    rect.size.width = screenRect.size.width * 6 / 10 - 9;
    self.m_editValue.frame = rect;
    
    rect = self.m_searchButton.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.m_searchButton.frame = rect;

    
    [self.m_comboField setTitleColor:[UIColor blackColor]];
    [self.m_comboField updateWithAvailableComboBoxItems:fields];
    
    [self.m_comboField.layer setCornerRadius:5.0];
    [self.m_comboField.layer setBorderWidth:1.0];
    [self.m_comboField.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.m_comboCriteria setTitleColor:[UIColor blackColor]];
    [self.m_comboCriteria updateWithAvailableComboBoxItems:criterias];
    
    [self.m_comboCriteria.layer setCornerRadius:5.0];
    [self.m_comboCriteria.layer setBorderWidth:1.0];
    [self.m_comboCriteria.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:FALSE animated:animated];

    // Configure the view for the selected state
}

#pragma mark - ComboBoxViewDelegate Methods

- (void) expandedComboBoxView:(ComboBoxView *)comboBoxView {
    
}

- (void) collapseComboBoxView:(ComboBoxView *)comboBoxView {
    
}

- (void) selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView {

    
}
@end

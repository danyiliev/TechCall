//
//  ARListViewCell.h
//  Tech
//
//  Created by apple on 3/4/16.
//  Copyright © 2016 Luke Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_arName;
@property (weak, nonatomic) IBOutlet UILabel *m_arPhone;
@property (weak, nonatomic) IBOutlet UILabel *m_arAddress;
@end

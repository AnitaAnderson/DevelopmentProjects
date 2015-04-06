//
//  GenericItemCell.h
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenericItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *genericNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *genericQtyField;

@end

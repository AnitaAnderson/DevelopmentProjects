//
//  DrinksCollectionViewController.h
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericItemCell.h"

@interface DrinksCollectionViewController : UIViewController{
    NSMutableArray *drinksArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *drinksCollectionView;

@end

//
//  DrinksCollectionViewController.h
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericItemCell.h"

@interface InventoryCollectionViewController : UIViewController{
//    NSMutableArray *inventoryArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *inventoryCollectionView;
@property (strong, nonatomic) IBOutlet NSMutableArray *inventoryArray;

@end

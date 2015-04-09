//
//  GenericInventoryItem.h
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/6/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericInventoryItem : NSObject


@property(nonatomic, weak) NSString *name;
@property(nonatomic, weak) NSString *inputQty;
@property(nonatomic, weak) NSString *itemType;
@property(nonatomic, weak) NSIndexPath *indexPath;
@property(nonatomic, weak) NSString *parentObjectId;
@end

//
//  DrinksCollectionViewController.m
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import "InventoryCollectionViewController.h"
#import <Parse/Parse.h>
#import "InventoryHeaderReusableView.h"

@interface InventoryCollectionViewController ()

@end

@implementation InventoryCollectionViewController

@synthesize inventoryCollectionView, inventoryDict, inventoryOrderDict;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    inventoryDict = [[NSMutableDictionary alloc]initWithCapacity:3];
    inventoryOrderDict = [[NSMutableDictionary alloc]initWithCapacity:3];

    NSLog(@"parse: retrieving data");
    [self getDrinkList];
    [self getProductsList];
    [self getSuppliesList];
    NSLog(@"parse: finished retrieving data");
    @try {
        UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)inventoryCollectionView.collectionViewLayout;
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    }
    @catch (NSException *exception) {
        NSLog(exception);
    }
   
    
//    [inventoryCollectionView reloadData];
}

#pragma mark - actions
- (IBAction)saveInventoryReport:(id)sender {
    PFObject *shiftInventory = [PFObject objectWithClassName:@"ShiftInventory"];
    shiftInventory[@"amPM"]= @"am";
    shiftInventory[@"shiftDate"]=[NSDate date];
    shiftInventory[@"inventoryItems"]= inventoryOrderDict.allValues;
    [shiftInventory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"success");
        }
        else{
            NSLog(@"fail");
        }
    }];
    
}

#pragma mark - Parse methods
-(void)getDrinkList{
    PFQuery *query = [PFQuery queryWithClassName:@"InventoryItems"];
    [query whereKey:@"type" equalTo:@"Drink"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: drinks data");

            NSMutableArray *drinksArray = [[NSMutableArray alloc]initWithArray:objects];
            [inventoryDict setObject:drinksArray forKey:@"Drinks"];
            [inventoryCollectionView reloadData];
        }
    }];
}


-(void)getProductsList{
    PFQuery *query = [PFQuery queryWithClassName:@"InventoryItems"];
    [query whereKey:@"type" equalTo:@"Ingridient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: Products data");

            NSMutableArray *productsArray  = [[NSMutableArray alloc]initWithArray:objects];
            [inventoryDict setObject:productsArray forKey:@"Products"];
            [inventoryCollectionView reloadData];
        }
    }];
}

-(void)getSuppliesList{
    PFQuery *query = [PFQuery queryWithClassName:@"InventoryItems"];
    [query whereKey:@"type" equalTo:@"Supply"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: Supplies data");
            NSMutableArray *suppliesArray  = [[NSMutableArray alloc]initWithArray:objects];
            [inventoryDict setObject:suppliesArray forKey:@"Supplies"];
            [inventoryCollectionView reloadData];
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(inventoryDict)
        return [[inventoryDict allKeys] count];
    return 1;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *keys = [inventoryDict allKeys];
    NSArray *individualArray = [inventoryDict objectForKey:[keys objectAtIndex:section]];
    return [individualArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"genericItemCell";
    GenericItemCell *genericItemCell = (GenericItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSArray *keys = [inventoryDict allKeys];
    NSArray *individualArray = [inventoryDict objectForKey:[keys objectAtIndex:indexPath.section]];

    PFObject *inventoryItem = [individualArray objectAtIndex:indexPath.row];
    genericItemCell.genericNameLabel.text = [inventoryItem objectForKey:@"name"];
    genericItemCell.genericQtyField.text = @"";
    genericItemCell.genericQtyField.delegate = self;

    //updating tag of textfield to section(+1)row so we can update array object
    {
        //need to add 1 to section, since section starts with 0 and int value does not show leading 0
        NSString *str = [NSString stringWithFormat:@"%li%li", ((long)indexPath.section + 1), (long)indexPath.row];
        NSInteger aValue = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue];
        
        genericItemCell.genericQtyField.tag=aValue;
        
        [inventoryOrderDict setValue:inventoryItem forKey:str];
    }
        return genericItemCell;
}


#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    
    if(kind == UICollectionElementKindSectionHeader){
        InventoryHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView"forIndexPath:indexPath];
        NSArray *keys = [inventoryDict allKeys];
        NSString *headerTitle = keys[indexPath.section];
//        NSString *headerTitle;
//        if (indexPath.section == 0) {
//            headerTitle = @"Products";
//        }
//        else if (indexPath.section == 1) {
//            headerTitle = @"Supplies";
//        }
//        else if (indexPath.section == 2) {
//            headerTitle = @"Drinks";
//        }
//
        headerView.headerLabel.text = headerTitle;
        reusableView = headerView;
        
    }
    
    return reusableView;
    
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    PFObject *updatedInventoryItem = [inventoryOrderDict objectForKey:[NSString stringWithFormat:@"%ld", (long)textField.tag]];
    [updatedInventoryItem setValue:textField.text forKey:@"updatedQty"];
    

    return YES;
}
@end

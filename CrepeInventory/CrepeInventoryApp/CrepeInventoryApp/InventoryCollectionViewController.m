//
//  DrinksCollectionViewController.m
//  CrepeInventoryApp
//
//  Created by Andreh Anderson on 4/5/15.
//  Copyright (c) 2015 yoBLOB. All rights reserved.
//

#import "InventoryCollectionViewController.h"
#import <Parse/Parse.h>

@interface InventoryCollectionViewController ()

@end

@implementation InventoryCollectionViewController

@synthesize inventoryCollectionView, inventoryArray;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
//    // Register cell classes
//    [self.drinksCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    
    // Do any additional setup after loading the view.
    
    dispatch_queue_t globalConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    inventoryArray = [[NSMutableArray alloc]initWithCapacity:3];
    NSLog(@"parse: retrieving data");
    [self getDrinkList];
    [self getProductsList];
    [self getSuppliesList];
    NSLog(@"parse: finished retrieving data");

//    [inventoryCollectionView reloadData];
}

#pragma mark - Parse methods
-(void)getDrinkList{
    PFQuery *query = [PFQuery queryWithClassName:@"Drinks"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: drinks data");

            NSMutableArray *drinksArray = [[NSMutableArray alloc]initWithArray:objects];
            [self.inventoryArray addObject:drinksArray];
            [inventoryCollectionView reloadData];
        }
    }];
}


-(void)getProductsList{
    PFQuery *query = [PFQuery queryWithClassName:@"Products"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: Products data");

            NSMutableArray *productsArray  = [[NSMutableArray alloc]initWithArray:objects];
            [inventoryArray addObject:productsArray];
            [inventoryCollectionView reloadData];
        }
    }];
}

-(void)getSuppliesList{
    PFQuery *query = [PFQuery queryWithClassName:@"Supplies"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"parse: Supplies data");

            NSMutableArray *suppliesArray  = [[NSMutableArray alloc]initWithArray:objects];
            [inventoryArray addObject:suppliesArray];
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
    if(inventoryArray)
        return [inventoryArray count];
    return 1;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *individualArray = [inventoryArray objectAtIndex:section];
    return [individualArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"genericItemCell";
    GenericItemCell *genericItemCell = (GenericItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSArray *individualArray = [inventoryArray objectAtIndex:indexPath.section];
    PFObject *inventoryItem = [individualArray objectAtIndex:indexPath.row];
    genericItemCell.genericNameLabel.text = [inventoryItem objectForKey:@"name"];
    return genericItemCell;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

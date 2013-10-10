//
//  MasterViewController.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

-(void)viewDidLoad
{
    self.model = [[ArticlesModel alloc] init:[ObjectConfig config:@{@"observers":@[self]}]];
}


- (IBAction)sortChanged:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 1){
        [self.model setState:@{@"direction":@"DESC"}];
    }else{
        [self.model setState:@{@"direction":@"ASC"}];        
    }
}

-(void)onModelStateChange:(NSString*)name
{
    [self.tableView reloadData];
}

#pragma mark UITableView data source methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.model.sections[section];
    return [sectionInfo numberOfObjects];
}

#pragma mark UITableView delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //Attempt to assign row title/name attribute to cell text label
    id row = [self.model objectAtIndexPath:indexPath];
    if([row respondsToSelector:@selector(title)]) cell.textLabel.text = [row title];
    
    return cell;
}

@end

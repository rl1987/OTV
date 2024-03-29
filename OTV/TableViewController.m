//
//  TableViewController.m
//  OTV
//
//  Created by Rimantas Lukosevicius on 04/03/2018.
//  Copyright © 2018 Rimantas Lukosevicius. All rights reserved.
//

#import "TableViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "Browser.h"
#import "ChoiceViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) Browser *browser;
@property (nonatomic, strong) NSArray<OTVItem *> *items;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.browser = [[Browser alloc] init];
    
    [self browseItem:nil];
}

- (void)browseItem:(OTVItem *)item
{
    [SVProgressHUD show];
    
    [self.browser browseToItem:item
         withCompletionHandler:^(NSArray<OTVItem *> *items, NSError *error) {
             if (items && !error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.items = items;
                     [SVProgressHUD dismiss];
                     [self.tableView reloadData];
                 });
            } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [SVProgressHUD showErrorWithStatus:@"Error"];
                 });
             }
         }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"
                                                            forIndexPath:indexPath];
    
    OTVItem *item = self.items[indexPath.row];
    
    cell.textLabel.text = item.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OTVItem *item = self.items[indexPath.row];
    
    if (item.isDirectory) {
        [self browseItem:item];
    } else {
        [self performSegueWithIdentifier:@"choice" sender:item];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"choice"]) {
        OTVItem *item = (OTVItem *)sender;
    
        ChoiceViewController *cvc = (ChoiceViewController *)segue.destinationViewController;
    
        cvc.item = item;
    }
}

@end

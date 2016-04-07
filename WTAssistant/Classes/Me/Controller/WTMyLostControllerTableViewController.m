//
//  WTMyLostControllerTableViewController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTMyLostControllerTableViewController.h"
#import "WTCompseLoseControllerViewController.h"
#import "WTNavControllerViewController.h"
@interface WTMyLostControllerTableViewController ()

@end

@implementation WTMyLostControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(composeLost)];
   }
-(void)composeLost{
    WTCompseLoseControllerViewController *composeVC=[[WTCompseLoseControllerViewController alloc] init];
    WTNavControllerViewController *nav=[[WTNavControllerViewController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end

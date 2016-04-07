//
//  WTDiscoverController.m
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTDiscoverController.h"
#import "WTDiscoverCell.h"
#import "WTDiscover.h"
#import "WTLoseController.h"
#import "WTMessageContentController.h"
@interface WTDiscoverController ()
@property (nonatomic,strong) NSArray *discovers;
@end

@implementation WTDiscoverController
-(NSArray *)discovers{
    if (_discovers==nil) {
        _discovers=[WTDiscover discover];
    }
    return _discovers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.rowHeight = 84;
    
    self.tableView.sectionFooterHeight = 10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discovers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTDiscover *discover=self.discovers[indexPath.row];
    WTDiscoverCell *cell=[WTDiscoverCell cellWithTableView:tableView];
    cell.discover=discover;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        WTMessageContentController *newsContentVC=[[WTMessageContentController alloc] init];
        [self.navigationController pushViewController:newsContentVC animated:YES];
    }else if(indexPath.row==1){
       
    }
    else{
        WTLoseController *loseVC=[[WTLoseController alloc] init];
        [self.navigationController pushViewController:loseVC animated:YES];
    }
}

@end

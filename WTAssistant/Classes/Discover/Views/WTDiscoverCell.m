//
//  WTDiscoverCell.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTDiscoverCell.h"
#import "WTDiscover.h"
@implementation WTDiscoverCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"discover";
    WTDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WTDiscoverCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(void)setDiscover:(WTDiscover *)discover{
    _discover=discover;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.text = discover.listName;
    self.imageView.image = [UIImage imageNamed:discover.listIcon];
}


@end

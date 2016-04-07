//
//  WTHomeListCell.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTHomeListCell.h"
#import "WTHomeList.h"
@implementation WTHomeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"list";
    WTHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WTHomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.textLabel.font=[UIFont systemFontOfSize:12];
    }
    return self;
}
-(void)setHomeList:(WTHomeList *)homeList{
    _homeList=homeList;
    self.imageView.image=[UIImage imageNamed:self.homeList.listIcon];
    self.textLabel.text=self.homeList.listName;
}
@end

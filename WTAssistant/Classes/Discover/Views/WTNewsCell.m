//
//  WTNewsCell.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTNewsCell.h"
#import "WTMessageNews.h"
#import "UIImageView+WebCache.h"
@interface WTNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation WTNewsCell

- (void)awakeFromNib {
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMessageNews:(WTMessageNews *)messageNews{
    _messageNews=messageNews;
    // 1.图片
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:messageNews.newsImg] placeholderImage:[UIImage imageNamed:@"blue"]];
    //2 时间
    self.timeLabel.text=messageNews.newsTime;
    self.titleLable.text=messageNews.newsTitle;
}
@end

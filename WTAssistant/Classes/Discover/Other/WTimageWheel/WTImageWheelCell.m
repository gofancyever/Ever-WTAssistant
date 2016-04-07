//
//  WTImageWheelCell.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTImageWheelCell.h"
#import "UIImageView+WebCache.h"
#import "WTMessageNews.h"
@interface WTImageWheelCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation WTImageWheelCell

-(void)setNews:(WTMessageNews *)news{
    _news=news;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:news.newsImg] placeholderImage:[UIImage imageNamed:@"blue"]];
    self.titleView.text=[NSString stringWithFormat:@"  %@",news.newsTitle];
}
@end

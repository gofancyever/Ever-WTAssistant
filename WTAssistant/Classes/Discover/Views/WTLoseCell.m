//
//  WTLoseCell.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTLoseCell.h"
#import "WTTest.h"
#import "UIImageView+WebCache.h"
@interface WTLoseCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation WTLoseCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setTest:(WTTest *)test{
    _test = test;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:test.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.label.text = test.price;
}
@end

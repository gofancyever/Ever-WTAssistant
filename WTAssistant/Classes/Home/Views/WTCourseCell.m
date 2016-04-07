//
//  WTCourseCell.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTCourseCell.h"
#import "WTSchedule.h"
#import "WTScheduleFrame.h"
@interface WTCourseCell ()
@property (nonatomic,weak) UILabel *courseOrder;
@property (nonatomic,weak) UIButton *status;
@property (nonatomic,weak) UILabel *courseName;
@property (nonatomic,weak) UILabel *courseLocation;

@end

@implementation WTCourseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"course";
    WTCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WTCourseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
        self.backgroundColor=[UIColor clearColor];
        //禁止与用户交互
        self.userInteractionEnabled=NO;
        /**
         *  初始化控件
         */
        [self setupCourseOrder];
        [self setupStatus];
        [self setupCourseName];
        [self setupCourseLocation];
    }
    return self;
}
#pragma mark-初始化控件
-(void)setupCourseOrder{
    UILabel *courseOrder=[[UILabel alloc] init];
    [self setlabel:courseOrder title:@"-" textColor:WTTextColor backgroundColor:WTTextBackgroundColor fontSize:17];
    courseOrder.textAlignment=NSTextAlignmentCenter;
    
    self.courseOrder=courseOrder;
}
-(void)setupStatus{
    UIButton *status=[[UIButton alloc] init];
    [status setImage:[UIImage imageNamed:@"status"] forState:UIControlStateDisabled];
    [status setImage:[UIImage imageNamed:@"status_disable"] forState:UIControlStateNormal];
    status.contentMode=UIViewContentModeCenter;
    status.backgroundColor=[UIColor whiteColor];
    [self addSubview:status];
    self.status=status;
}
-(void)setupCourseName{
    UILabel *courseName=[[UILabel alloc] init];
    [self setlabel:courseName title:@"--" textColor:WTTextColor backgroundColor:WTTextBackgroundColor fontSize:15];
    self.courseName=courseName;
}
-(void)setupCourseLocation{
    UILabel *courseLocation=[[UILabel alloc] init];
    [self setlabel:courseLocation title:nil textColor:WTTextColor backgroundColor:WTTextBackgroundColor fontSize:10];
    NSTextAttachment *att=[[NSTextAttachment alloc] init];
    att.image=[UIImage imageNamed:@"adress"];
    // 设置图片的尺寸
   NSMutableAttributedString *str =  [self courseLocationAttStringWithString:@"loaction"];
    courseLocation.attributedText=str;
    self.courseLocation=courseLocation;
}

#pragma mark-setter
-(void)setlabel:(UILabel *)label title:(NSString *)title textColor:(UIColor *) textColor backgroundColor:(UIColor *)backgroundColor fontSize:(CGFloat)fontSzie{
    label.text=title;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:fontSzie]];
    label.textColor=textColor;
    label.backgroundColor=backgroundColor;
    [self addSubview:label];

}
/**
 *  控件Frame 内容
 */
-(void)setScheduleFrame:(WTScheduleFrame *)scheduleFrame{
    _scheduleFrame=scheduleFrame;
    WTSchedule *schedule=scheduleFrame.schedule;
    
    self.courseOrder.frame=scheduleFrame.courseOrder;
    self.courseOrder.text=schedule.courseOrder;

    self.status.frame=scheduleFrame.status;
        CGFloat Edgeinset=scheduleFrame.status.size.height/2.5;
    self.status.imageEdgeInsets = UIEdgeInsetsMake(Edgeinset, Edgeinset, Edgeinset, Edgeinset);

    self.courseName.frame=scheduleFrame.courseName;
    self.courseName.text=schedule.courseName;
    
    self.courseLocation.frame=scheduleFrame.courseLocation;
    self.courseLocation.attributedText=[self courseLocationAttStringWithString:schedule.courseLocation];
    
    self.height=scheduleFrame.cellHeight;
    
}
/**
 *  传入字符串生成attributeString
 */
-(NSMutableAttributedString *)courseLocationAttStringWithString:(NSString *)contentText{
    
    NSTextAttachment *att=[[NSTextAttachment alloc] init];
    att.image=[UIImage imageNamed:@"adress"];
    // 设置图片的尺寸
    CGFloat attchWH = self.textLabel.font.lineHeight-2;
    att.bounds = CGRectMake(-5, -5, attchWH, attchWH);
    NSAttributedString *imageAttStr=[NSMutableAttributedString attributedStringWithAttachment:att];
    
    NSDictionary *textDict=@{
                             NSFontAttributeName:[UIFont systemFontOfSize:12]
                             };
    NSAttributedString *text=[[NSAttributedString alloc] initWithString:contentText attributes:textDict];
    
    NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc] init];
    [attStr appendAttributedString:imageAttStr];
    [attStr appendAttributedString:text];
    return attStr;
    
}
-(void)setSelected:(BOOL)selected{
    if (selected) {
        [self setSelectedStyle:self.courseOrder];
        [self setSelectedStyle:self.courseName];
        [self setSelectedStyle:self.courseLocation];
        [self setSelectedStyle:self.status];
        [self.status setEnabled:NO];
        
    }
}
-(void)setSelectedStyle:(UIView *)view{
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label=(UILabel *)view;
        label.textColor=[UIColor whiteColor];

    }
    [view setBackgroundColor:WTSelectedColor];
}
@end

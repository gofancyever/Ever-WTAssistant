//
//  WTWeatherView.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTWeatherView.h"
#import "WTWeather.h"
#import "FontHeader.h"

@interface WTWeatherView()
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (nonatomic,weak) IBOutlet UILabel *date;
@property (nonatomic,weak) IBOutlet UILabel *bottomInfo;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *icon;


@end

@implementation WTWeatherView


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
////        self.backgroundColor=[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.8];
//        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_bg"]]];
//        self.frame=CGRectMake(0, 0, self.width, 100);
//        //LeftView
//        [self setupLeftView];
//        //rigthView
//        [self setupRightView];
//    }
//    return self;
//}
//-(void)setupLeftView{
//    UIView *leftView=[[UIView alloc] init];
//    //城市
//    UILabel *city=[[UILabel alloc] init];
//    city.text=@"正在获取";
//    city.font=[UIFont boldSystemFontOfSize:20];
//    city.textAlignment=NSTextAlignmentCenter;
//    city.textColor=[UIColor whiteColor];
//    self.city=city;
//    //时间
//    UILabel *date=[[UILabel alloc] init];
//    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
//    fmt.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en-zh"];
//    fmt.dateFormat=@"yyyy-MM-dd E";
//    NSDate *now=[NSDate date];
//    NSString *dateStr=[fmt stringFromDate:now];
//    date.font=[UIFont boldSystemFontOfSize:10];
//    date.textAlignment=NSTextAlignmentCenter;
//    date.textColor=[UIColor whiteColor];
//    date.text=dateStr;
//    
//    [leftView addSubview:city];
//    [leftView addSubview:date];
//    [self addSubview:leftView];
//    self.leftView=leftView;
//    self.date=date;
//    
//}
//-(void)setupRightView{
//    UIView *rightView=[[UIView alloc] init];
//    //当前温度
//    UILabel *temp=[[UILabel alloc] init];
//    temp.text=@"正在获取信息";
//    temp.textColor=[UIColor whiteColor];
//    temp.textAlignment=NSTextAlignmentCenter;
//    temp.font=[UIFont systemFontOfSize:25];
//    [rightView addSubview:temp];
//    self.temp=temp;
//    //底部信息条
//    UILabel *bottomInfo=[[UILabel alloc] init];
//    [rightView addSubview:bottomInfo];
//    bottomInfo.textColor=[UIColor whiteColor];
//    bottomInfo.textAlignment=NSTextAlignmentCenter;
//    bottomInfo.text=@"- | - | -";
//    bottomInfo.font=[UIFont systemFontOfSize:12];
//    bottomInfo.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    bottomInfo.layer.cornerRadius=10;
//    bottomInfo.clipsToBounds=YES;
//    self.bottomInfo=bottomInfo;
//    self.rightView=rightView;
//    [self addSubview:rightView];
//}
//
////设置空间frame
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    //设置leftView Frame
//    CGFloat leftViewX=0;
//    CGFloat leftViewY=0;
//    CGFloat leftViewWH=self.height;
//    self.leftView.frame=CGRectMake(leftViewX, leftViewY, leftViewWH, leftViewWH);
//    //设置leftView 内空间Frame
//    self.city.frame=CGRectMake(0, 0, leftViewWH, leftViewWH*0.7);
//    self.date.frame=CGRectMake(0, self.city.height, leftViewWH, self.height-self.city.height);
//
//    //设置rightView Frame
//    CGFloat rightX=leftViewWH;
//    CGFloat rightY=0;
//    CGFloat rightW=self.width-leftViewWH;
//    CGFloat rightH=leftViewWH;
//    self.rightView.frame=CGRectMake(rightX, rightY, rightW, rightH);
////    设置right内控件尺寸
//    CGFloat tempX=0;
//    CGFloat tempY=0;
//    CGFloat tempW=rightW;
//    CGFloat tempH=rightH*0.6;
//    self.temp.frame=CGRectMake(tempX, tempY, tempW, tempH);
////    //设置底部信息条
//    CGFloat margin=10;
//    CGFloat bottomX = margin ;
//    CGFloat bottomY = tempH ;
//    CGFloat bottomW = rightW-2*margin ;
//    CGFloat bottomH = rightH*0.3;
//    self.bottomInfo.frame=CGRectMake(bottomX, bottomY, bottomW, bottomH);
//   
//    
//}
//
-(void)setWeather:(WTWeather *)weather{
    _weather=weather;
    //城市
    self.city.text=weather.city;
    //温度
    self.temp.text=[NSString stringWithFormat:@"%@ ℃",weather.temp];
    NSString *tempRange=[NSString stringWithFormat:@"%@℃ ~ %@℃",weather.l_tmp,weather.h_tmp];
    //底部信息
    self.bottomInfo.text=[NSString stringWithFormat:@"%@ | %@ | %@",weather.weather,tempRange,weather.WS];
    //时间
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    fmt.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en-zh"];
    fmt.dateFormat=@"MM-dd E";
    NSDate *now=[NSDate date];
    NSString *dateStr=[fmt stringFromDate:now];
    self.date.text=dateStr;
    //icon

    [self.icon setFont:[UIFont fontWithName:KFontName size:self.icon.frame.size.height*0.5]];
    [self.icon setText:weatherDict[weather.weather]];
    
    
}

+(instancetype)weatherView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WTWeatherView" owner:nil options:nil] lastObject];
}

@end

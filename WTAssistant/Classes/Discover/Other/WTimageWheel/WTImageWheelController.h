//
//  WTImageWheelController.h
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WTImageWheelControllerImageWheelMessage=1,
    WTImageWheelControllerImageWheelSchoolMsg=0
}WTImageWheelControllerType;

@interface WTImageWheelController : UIViewController
-(instancetype)initWithImageWheelType:(WTImageWheelControllerType)type;
@end

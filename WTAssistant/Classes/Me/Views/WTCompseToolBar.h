//
//  WTCompseToolBar.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WTComposeToolbarButtonTypeCamera, // 拍照
    WTComposeToolbarButtonTypePicture // 相册
   
} WTComposeToolbarButtonType;

@class WTCompseToolBar;

@protocol WTCompseToolBarDelegate <NSObject>
@optional
- (void)composeToolbar:(WTCompseToolBar *)toolbar didClickButton:(WTComposeToolbarButtonType)buttonType;
@end

@interface WTCompseToolBar : UIView

@property (nonatomic, weak) id<WTCompseToolBarDelegate> delegate;

@end

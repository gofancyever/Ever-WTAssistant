//
//  WTComposePhotoView.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTComposePhotoView : UIView
- (void)addPhoto:(UIImage *)photo;
//@property (nonatomic, strong, readonly) NSArray *photos;
//- (NSArray *)photos;

@property (nonatomic, strong, readonly) NSMutableArray *photos;

@end

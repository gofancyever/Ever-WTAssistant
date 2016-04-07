//
//  WTWaterflowLayout.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTWaterflowLayout;

@protocol WTWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(WTWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface WTWaterflowLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<WTWaterflowLayoutDelegate> delegate;

@end

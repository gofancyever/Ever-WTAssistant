//
//  WTLoseController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTLoseController.h"
#import "WTWaterflowLayout.h"
#import "WTLoseCell.h"
#import "WTLoseTool.h"
#import "MJRefresh.h"
//测试数据模型
#import "WTTest.h"

@interface WTLoseController() <UICollectionViewDataSource, UICollectionViewDelegate, WTWaterflowLayoutDelegate>
@property (nonatomic, strong) NSArray *tests;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation WTLoseController
static NSString *const ID = @"lose";
- (NSMutableArray *)tests
{
    if (_tests == nil) {
        _tests = [WTLoseTool loseStatus];
    }
    return _tests;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"寻物公告";
    WTWaterflowLayout *layout = [[WTWaterflowLayout alloc] init];
    layout.delegate = self;
    layout.columnsCount = 2;
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"WTLoseCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 3.增加刷新控件
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];
}
- (void)loadMoreShops
{
    //加载更多
}

#pragma mark - <HMWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(WTWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    WTTest *test = self.tests[indexPath.item];
    return test.h / test.w * width;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tests.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WTLoseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.test = self.tests[indexPath.item];
    return cell;
}

@end

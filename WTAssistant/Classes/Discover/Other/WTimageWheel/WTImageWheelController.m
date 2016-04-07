//
//  WTImageWheelController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTImageWheelController.h"
#import "UIColor+Random.h"
#import "WTImageWheelCell.h"
#import "WTNewsTool.h"
NSString * const WTCellIdentifier = @"news";
@interface WTImageWheelController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageContol;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *newses;

@end

@implementation WTImageWheelController
-(instancetype)initWithImageWheelType:(WTImageWheelControllerType)type{
    if (self=[super init]) {
        if (type==WTImageWheelControllerImageWheelMessage) {
            self.newses=[WTNewsTool newsMessageImageWheelArray:5];
        }
        else {
            self.newses=[WTNewsTool newsSchoolMsgImageWheelArray:5];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width , 200);
    //初始化CollectionView
    [self setupCollectionView];
    //初始化PageControl
    [self setupPageControl];
    
//     添加定时器
    [self addTimer];
    

}
#pragma mark - 初始化方法
/**
 *  初始化pageControl
 */
-(void)setupPageControl{
    // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 总页数
    pageControl.numberOfPages = self.newses.count;
    // 分页初始页数为0
    pageControl.currentPage = 0;
    // 控件尺寸
    //    CGSize size = [_pageControl sizeForNumberOfPages:count];
    CGFloat pageControlX=self.view.bounds.size.width-75;
    CGFloat pageControlY=self.view.bounds.size.height-30;
    pageControl.frame = CGRectMake(pageControlX, pageControlY, 70, 30);
    self.pageContol=pageControl;
    [self.view addSubview:pageControl];
    

}
/**
 *  初始化CollectionView
 */
-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.showsVerticalScrollIndicator=NO;
    collectionView.pagingEnabled=YES;
    
    collectionView.delegate=self;
    collectionView.dataSource=self;
    self.collectionView=collectionView;
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"WTImageWheelCell" bundle:nil] forCellWithReuseIdentifier:WTCellIdentifier];
    
    [self.view addSubview:self.collectionView];
    //     默认显示最中间的那组
    [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:50] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    


}

#pragma mark -其他方法
/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:100/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WTImageWheelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WTCellIdentifier forIndexPath:indexPath];
    
    cell.news=self.newses[indexPath.item];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.frame.size;
}



#pragma mark-点击图片轮播通知
-(void)contentViewClick:(NSIndexPath *)index{
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"contentViewClick:" object:self userInfo:@{@"model":self.newses[index.item]}];
    
}
#pragma mark  - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self contentViewClick:indexPath];
}

/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"scrollViewDidEndDragging--松开");
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
    self.pageContol.currentPage = page;
}
@end

//
//  WTCompseLoseControllerViewController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTCompseLoseControllerViewController.h"
#import "WTComposePhotoView.h"
#import "WTCompseToolBar.h"
#import "WTComposeTool.h"
@interface WTCompseLoseControllerViewController ()<WTCompseToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) UITextView *textView;

/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) WTComposePhotoView *photosView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) WTCompseToolBar *toolbar;
/** 发布过的信息 */
@property (nonatomic,strong) NSArray *composeInfo;
@end

@implementation WTCompseLoseControllerViewController
-(NSArray *)composeInfo{
    if (_composeInfo==nil) {
        _composeInfo=[WTComposeTool getComposeInfo];
    }
    return _composeInfo;
}
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // 设置导航栏内容
    [self setupNav];
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosView];
}
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发布信息";

}
/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    UITextView  *textView = [[UITextView alloc] init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    [textView endEditing:YES];
    self.textView = textView;
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    // 表情选中的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];
//    
//    // 删除文字的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:HWEmotionDidDeleteNotification object:nil];
}

/**
 * 添加相册
 */
- (void)setupPhotosView
{
    WTComposePhotoView *photosView = [[WTComposePhotoView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    // 随便写的
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
/**
 * 添加工具条
 */
- (void)setupToolbar
{
    WTCompseToolBar *toolbar = [[WTCompseToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height-65;
//    toolbar.y=150;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}


-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height-60;
        }
    }];

}
-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发布信息
 */
-(void)send{
    
    [WTComposeTool composeLost:self.textView.text image:[self.photosView.photos firstObject]result:^(WTcomposeToolResult result) {
        NSLog(@"%u",result);
    }];
       // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark-toolbarDelegate
-(void)composeToolbar:(WTCompseToolBar *)toolbar didClickButton:(WTComposeToolbarButtonType)buttonType{
    //创建控制器
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;

    if (buttonType==WTComposeToolbarButtonTypeCamera) {//打开相机
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{//打开相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片 设置图片
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    //隐藏当前模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.composeInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //可重用标示符
    static NSString *ID=@"Cell";
    //让表哥从缓冲区查找可重用
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果没有找到可重用标示符
    if (cell==nil) {
        //实例化cell
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
//    cell.model=self.composeInfo[indexPath.row];
    return cell;
}

@end

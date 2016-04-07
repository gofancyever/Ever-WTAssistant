//
//  WTProfileInfoController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTProfileInfoController.h"
#import "WTEditInfoController.h"
#import "XMPPvCardTemp.h"

@interface WTProfileInfoController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,WTEditInfoControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nickName;//昵称
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;//头像
@property (weak, nonatomic) IBOutlet UILabel *weChatID;//微信
@property (weak, nonatomic) IBOutlet UILabel *studenID;//学号
@property (weak, nonatomic) IBOutlet UILabel *classInfo;//班级

@end

@implementation WTProfileInfoController


- (void)viewDidLoad {
    [super viewDidLoad];
    //加载电子名片信息
    [self loadvCardInfo];
    
    

}
/**
 *  加载电子名片信息
 */
-(void)loadvCardInfo{
    XMPPvCardTemp *myCard = [WCXMPPTool sharedInstance].vCard.myvCardTemp;
    if (myCard.photo) {
        self.headerIcon.image=[UIImage imageWithData:myCard.photo];
    }
    self.nickName.text=myCard.nickname;
    self.weChatID.text=myCard.note;
    self.studenID.text=myCard.title;
    if (myCard.orgUnits.count>0) {
        self.classInfo.text=myCard.orgUnits[0];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取celltag
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag==2) {//不做任何操作
        return;
    }
    else if (cell.tag==0){//选择照片
        
        //创建控制器
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        //设置允许编辑
        imagePicker.allowsEditing=YES;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self) myself=self;
        [alert addAction:[UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [myself presentViewController:imagePicker animated:YES completion:nil];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [myself presentViewController:imagePicker animated:YES completion:nil];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    else{//跳到下一控制器
        [self performSegueWithIdentifier:@"EditCardSegue" sender:cell];
        
    }
}
//拦截要跳转的控制器
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id destVc=segue.destinationViewController;
    if ([destVc isKindOfClass:[WTEditInfoController class]]) {
        WTEditInfoController *editVC=destVc;
        editVC.cell=sender;
        editVC.delegate=self;
    }
}
#pragma mark -图片选择器代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片 设置图片
    UIImage *image=info[UIImagePickerControllerEditedImage];
    self.headerIcon.image=image;
    //隐藏当前模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    //更新数据
    [self editProfileViewControllerDidSave];
  
}
-(void)editProfileViewControllerDidSave{

    //获取当前的电子名片信息
    XMPPvCardTemp *vcard=[WCXMPPTool sharedInstance].vCard.myvCardTemp;
    vcard.nickname=self.nickName.text;
    vcard.note=self.weChatID.text;
    vcard.title=self.studenID.text;
    vcard.photo=UIImagePNGRepresentation(self.headerIcon.image);
    //更新
    [[WCXMPPTool sharedInstance].vCard updateMyvCardTemp:vcard];

}
@end

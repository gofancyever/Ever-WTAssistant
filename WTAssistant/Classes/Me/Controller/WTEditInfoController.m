//
//  WTEditInfoController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTEditInfoController.h"
#import "XMPPvCardTemp.h"
@interface WTEditInfoController ()
@property (weak, nonatomic) IBOutlet UITextField *editContent;

@end

@implementation WTEditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.cell.textLabel.text;
    self.editContent.text=self.cell
    .detailTextLabel.text;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
   }

-(void)saveClick{
    //更改当前cell
    self.cell.detailTextLabel.text=self.editContent.text;
    [self.cell layoutSubviews];
    //移除
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(editProfileViewControllerDidSave)]) {
        [self.delegate editProfileViewControllerDidSave];
    }
   
}
@end

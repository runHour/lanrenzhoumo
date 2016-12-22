//
//  DetailViewController.m
//   详情界面
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/31.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "DetailViewController.h"
#import "ScrollTopTableViewCell.h"
#import "PriceTableViewCell.h"
#import "TextTableViewCell.h"
#import "ImgViewTableViewCell.h"
#import "MassageTableViewCell.h"
#import "AFNetworkingRequest.h"
#import <UIImageView+WebCache.h>
#import "TitleTableViewCell.h"
#import "HuodongTableViewCell.h"
#import "PanScrollView.h"

#define scrollTopTableViewCell @"scrollTopTableViewCell"
#define priceTableViewCell      @"PriceTableViewCell"
#define textTableViewCell       @"TextTableViewCell"
#define imgViewTableViewCell     @"ImgViewTableViewCell"
#define massageTableViewCell    @"MassageTableViewCell"
#define titleTableViewCell       @"TitleTableViewCell"
#define huodongTableViewCell     @"HuodongTableViewCell"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSMutableArray *heightArray;//高度数组
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)BOOL    isSet;//判断状态栏状态
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)PanScrollView *panView;
@property(nonatomic,strong)NSMutableString *tipString;//温馨提示
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tipString=[NSMutableString string];
    _heightArray=[[NSMutableArray alloc]initWithObjects:@300,@60,@40, nil];//写死前三行高度
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.alpha=0;
    [self.navigationController.navigationBar  setTintColor:[UIColor clearColor]];
    [self creatTopView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self registCell];
    [self getResourceWithLeo_id:self.leo_id];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollImg:) name:@"scrollImg"  object:nil];
    }
//注册cell
-(void)registCell{

    [self.tableView registerNib:[UINib nibWithNibName:@"ScrollTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:scrollTopTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PriceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:priceTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"timetextTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"adressTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HuodongTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:huodongTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:textTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImgViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:imgViewTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"MassageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:massageTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"MassageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"massageTipCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:titleTableViewCell];
}

-(UITableView*)tableView{

    if(!_tableView ){
        _tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        //设置分行线的风格
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }

    return _tableView;
}


#pragma tableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *description=self.dataDic[@"description"];
    return description.count+8;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *description=self.dataDic[@"description"];
    
    if (indexPath.row==0) {
        ScrollTopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:scrollTopTableViewCell forIndexPath:indexPath];
        NSMutableArray *imgArray=self.dataDic[@"images"];
        [cell  setScrollViewWithImg:imgArray];
        cell.highlighted=NO;
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row==1){
        TitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:titleTableViewCell forIndexPath:indexPath ];
        cell.title.text=self.dataDic[@"title"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    else if (indexPath.row==2){
        PriceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:priceTableViewCell forIndexPath:indexPath];
        NSDictionary *category=self.dataDic[@"category"];
        [cell.categroyImg sd_setImageWithURL:[NSURL URLWithString:category[@"icon_view"]] placeholderImage:[UIImage imageNamed:@"detailholdImg"]];
        cell.categroyLabel.text=category[@"cn_name"];
        cell.priceLabel.text=[NSString stringWithFormat:@"¥%ld",[self.dataDic[@"min_price"] integerValue]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    else if (indexPath.row==3){
        TextTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"timetextTableViewCell" forIndexPath:indexPath];
        cell.contentlabel.text=[self.dataDic[@"time"] valueForKey:@"info"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    else if(indexPath.row==4){
        TextTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"adressTableViewCell" forIndexPath:indexPath];
        NSString *pioName=self.dataDic[@"poi"];//店铺名字
        cell.contentlabel.text=[self.dataDic[@"address"] stringByAppendingFormat:@"-%@",pioName];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
    }
    
    else if (indexPath.row==5){
        HuodongTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:huodongTableViewCell forIndexPath:indexPath];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    else if (indexPath.row==(description.count+6)){
         MassageTableViewCell *massageCell=[tableView dequeueReusableCellWithIdentifier:massageTableViewCell forIndexPath:indexPath];
        massageCell.title.text=@"预定须知";
        NSArray *booking_policy=self.dataDic[@"booking_policy"];
        NSString *content=[booking_policy[0] valueForKey:@"content"];
        massageCell.contentLabel.text=[NSString stringWithFormat:@"1.%@\n",content];
        massageCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return massageCell;
    }
    else if (indexPath.row==(description.count+7)){
    MassageTableViewCell *massageCell=[tableView dequeueReusableCellWithIdentifier:@"massageTipCell"forIndexPath:indexPath];
        massageCell.title.text=@"温馨提示";
        NSMutableString *tipString=[NSMutableString string];
        NSArray *tips=self.dataDic[@"lrzm_tips"];
        for (int i=0; i<tips.count; i++) {
            NSString *str=[NSString stringWithFormat:@"%d.%@\n",i+1,[tips[i] valueForKey:@"content"]];
            [tipString appendString:str];
        }
        massageCell.contentLabel.text=tipString;
       massageCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return massageCell;
    }
    else {
        NSString *type=[description[indexPath.row-6] valueForKey:@"type"];
        NSString *content=[description[indexPath.row-6] valueForKey:@"content"];
        if ([type isEqualToString:@"text"]) {
            TextTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:textTableViewCell forIndexPath:indexPath];
            cell.contentlabel.text=content;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
           
            return cell;
            
        }
        else{
            ImgViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:imgViewTableViewCell forIndexPath:indexPath];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:content]];
            return cell;
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_heightArray.count<4) {
        if (indexPath.row==0) {
            return 300;
        }
        else{
            
            return 218;
            
        }
    }
    else{
        CGFloat height=[self.heightArray[indexPath.row] floatValue];
        return  height;
    }
   
}

#pragma 网络请求
-(NSMutableDictionary*)dataDic{
    if (!_dataDic) {
        _dataDic=[[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}
-(void)getResourceWithLeo_id:(NSInteger)leo_id{
    NSString *urlString=[NSString stringWithFormat:@"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=%ld&session_id=0000423f77528bee1b0655a91c1aaadf001096&v=4",leo_id];
    NSLog(@"HHHH====%@\n\n\n\n\n",urlString);
    [AFNetworkingRequest getRequestWithUrl:urlString result:^(id result) {
        self.dataDic=result[@"result"];
        [self setHeight];
        [self.tableView reloadData];
    }];


}

//设置高度数组
-(void)setHeight{
    //时间
    NSDictionary *timeD=self.dataDic[@"time"];
    NSString *time=timeD[@"info"];
    CGFloat h=[time boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    [self.heightArray addObject:[NSNumber numberWithFloat:h+20]];
    //地址
    NSString *pioName=self.dataDic[@"poi"];//店铺名字
    NSString *address=[self.dataDic[@"address"] stringByAppendingFormat:@"-%@",pioName];
    CGFloat ah=[address boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    [self.heightArray addObject:[NSNumber numberWithFloat:ah+20]];
    //活动详情
    [self.heightArray addObject:[NSNumber numberWithFloat:44]];
   NSArray *description=self.dataDic[@"description"];
    for (int i=0; i<description.count; i++) {
        NSString *type=[description[i] valueForKey:@"type"];
        NSString *content=[description[i] valueForKey:@"content"];
        if ([type isEqualToString:@"text"]) {
            CGFloat height=[content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            [self.heightArray addObject:[NSNumber numberWithFloat:height+20]];
        }
        else{
        
            [self.heightArray addObject:[NSNumber numberWithFloat:218.0]];
        
        }
    }
    
    //预定须知
    CGFloat yudingHeight=90;
    [self.heightArray addObject:[NSNumber numberWithFloat:yudingHeight]];
    //温馨提示
    [self.heightArray addObject:[NSNumber numberWithFloat:120]];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y>10) {
        
        [self.btn setImage:[UIImage imageNamed:@"ic_nav_left"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1.0 animations:^{
            self.navigationController.navigationBar.alpha=0.95;
        }];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{
            self.navigationController.navigationBar.alpha=0;
        }];
   
    [_btn setImage:[UIImage imageNamed:@"ic_nav_left_white"] forState:UIControlStateNormal];
    
    }
}

//导航条上的view
-(void)creatTopView{
    _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    _topView.backgroundColor=[UIColor clearColor];
    [self.navigationController.view addSubview:_topView];
    
    _btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame=CGRectMake(20, 5, 40, 30);
    [_btn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setImage:[UIImage imageNamed:@"ic_nav_left_white"] forState:UIControlStateNormal];
    [_topView addSubview:_btn];




}
//导航栏返回
-(void)popAction:(UIButton*)btn{
    self.navigationController.navigationBar.alpha=1;
    [_topView removeFromSuperview];
    [self.navigationController.navigationBar  setTintColor:[UIColor lightGrayColor]];
    [self.navigationController popViewControllerAnimated:YES];
    

}
#pragma 通知回调
-(void)scrollImg:(NSNotification*)noti{
    NSInteger tag=[noti.userInfo[@"tag"] integerValue];
    NSMutableArray *imgview=noti.userInfo[@"imgArray"];
    _panView=[[PanScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds WithImgArray:imgview pageNum:tag];
    [self.view addSubview:_panView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelScroll:)];
    [_panView  addGestureRecognizer:tap];
}
//滚动视图手势事件
-(void)cancelScroll:(UITapGestureRecognizer*)tap{
//    [_panView removeAllChildView];
    [_panView removeFromSuperview];
    [_tableView reloadData];
    //给顶部scroll发通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startScroll" object:self];
}

@end

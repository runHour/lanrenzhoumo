//
//  CityViewController.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CityViewController.h"
#import "AFNetworkingRequest.h"
#import "CommonTableViewCell.h"
#import "CityModel.h"
#import "CityButton.h"
#import "CityView.h"
#define LEFTPadding   20
#define Width  self.view.frame.size.width
#define Height   self.view.frame.size.height
#define BtnWidth   (Width-LEFTPadding)/6
#define BtnHeight 30
@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;//城市数据数组
@property(nonatomic,strong)CityModel *model;
//@property(nonatomic,strong)CityModel *currentCityModel;
@property(nonatomic,strong)NSMutableArray *currentCityModelArray;



@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"newCell"];
    [_tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"commonCell"];
    //注册成为button的通知者-热门城市
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCityAction:) name:@"selectBtn" object:nil];
    //当前城市
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCityAction:) name:@"selectCurrBtn" object:nil];
    [self getCityMessage];
   
    
}



//获取城市列表
-(void)getCityMessage{
    NSString *cityUrlString=@"http://api.lanrenzhoumo.com/district/list/allcity?session_id=0000423f77528bee1b0655a91c1aaadf001096";
    
    [AFNetworkingRequest getRequestWithUrl:cityUrlString result:^(id result) {
         self.dataSource=result[@"result"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cellMassage" object:self userInfo:self.dataSource[1]];
        
        [self.tableView reloadData];
       
    }];

}
#pragma mark---属性懒加载

-(NSMutableArray*)dataSource{

    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }

    return _dataSource;
}
-(NSDictionary*)currentCityDic{
    if (!_currentCityDic) {
        _currentCityDic=[NSDictionary dictionary];
    }

    return _currentCityDic;
}

#pragma mark---代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"%ld",self.dataSource.count);
    return self.dataSource.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1) {
        return 1;
    }
    else{
        NSDictionary *dic=self.dataSource[section-1];
        NSArray *array=dic[@"city_list"];
        return array.count;
        
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row == 0) {
      
        CityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newCell" forIndexPath:indexPath];
       
        CityView  *cityView=[[CityView alloc]initWithFrame:cell.bounds fromModel:nil andJudge:0];
        [cityView creatCurrentBtnFromModel:self.currentCityDic];
        
        if (!self.currentCity) {
            self.currentCity=cityView.currentCityName;
        }
        else{
            self.navigationItem.title=[NSString stringWithFormat:@"当前城市—%@",self.currentCity];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.cellView addSubview:cityView];
        return cell;
    }
    else if(indexPath.section==1 ){
        NSDictionary *dic=self.dataSource[0];
        NSArray *array=dic[@"city_list"];
        NSMutableArray *cityArray=[NSMutableArray array];
        for (int i=0; i<array.count; i++) {
         CityModel *model = [[CityModel alloc]initWithDictionary:array[i]];
            [cityArray addObject:model];
        }
        CityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newCell" forIndexPath:indexPath];
        CityView  *cityView=[[CityView alloc]initWithFrame:cell.bounds fromModel:cityArray andJudge:1];
        [cell.cellView addSubview:cityView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
  
    }
    else{
        UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"commonCell" forIndexPath:indexPath];
        NSDictionary *dic=self.dataSource[indexPath.section-1];
        NSArray *array=dic[@"city_list"];
        NSDictionary *cityName=array[indexPath.row];
        cell.textLabel.text=cityName[@"city_name"];
        cell.textLabel.textColor=[UIColor blackColor];
        return cell;

    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 300;
    }
    else{
        return 40;
        
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    else if(section==1){
     NSString *str=@"热门城市";
        return  str;
    }
    else{
        NSString *str=[self.dataSource[section-1] valueForKey:@"begin_key"];
        return str;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return 0;
    }
    else {
    
     return   30;
    }
}

//通讯录右侧 缩写栏（索引）
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *array=[NSMutableArray arrayWithObjects:@"当前",@"热门",nil];
    for (int i=1; i<self.dataSource.count; i++) {
         NSString *str=[self.dataSource[i] valueForKey:@"begin_key"];
        [array addObject:str];
    }
    return array;
    
    
}

#pragma mark----通知回调方法
-(void)selectCityAction:(NSNotification*)noti{
     //协议
    NSDictionary *dic=noti.userInfo;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sendSelectCityMasage:)]) {
        [self.delegate sendSelectCityMasage:dic];
    }
     [self.navigationController popViewControllerAnimated:YES];

}
//通知移除
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1) {
        return;
    }
    else{
        NSDictionary *dic=self.dataSource[indexPath.section-1];
        NSArray *array=dic[@"city_list"];
        NSDictionary *cityName=array[indexPath.row];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(sendSelectCityMasage:)]) {
            [self.delegate sendSelectCityMasage:cityName];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}




@end

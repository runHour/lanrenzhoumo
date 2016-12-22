//
//  ViewController.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/27.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "MainSpaceModel.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "AFNetworkingRequest.h"
#import "CityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CatogroyView.h"
#import "CatagroyButton.h"
#import "DetailViewController.h"
#import <MJRefresh.h>
#define Width  self.view.bounds.size.width
#define Height self.view.bounds.size.height
#define MainCell @"mainCell"
//网络请求相同参数
#define Session_idAndV @"session_id=0000423f77528bee1b0655a91c1aaadf001096&v=3"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CityTableViewDelegate,CatogroyViewDelegate ,CLLocationManagerDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
//@property(nonatomic,strong)NSMutableArray  *dataSource;
@property(nonatomic,strong)UIBarButtonItem *leftItemBtn;
@property(nonatomic,assign)double  longitude;//经度
@property(nonatomic,assign)double   latitude;//纬度
@property(nonatomic,assign)NSInteger cityId;
@property(nonatomic,strong)CatogroyView *catogroyView;
@property(nonatomic,assign)BOOL   isOpen;//类目界面是否打开
@property(nonatomic,assign)NSInteger currpage;
//网络请求标识，判断当前时城市数据请求还是分区数据请求,no为城市，yes为分区
@property(nonatomic,assign)BOOL  isCityOrCategroy;

@property (nonatomic,strong)NSMutableArray *dataSource;
/*定位管理*/
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)CLLocation *currLocation;

@property(nonatomic,strong)NSMutableDictionary  *currCityDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //城市信息字典初始化
    _currCityDic=[NSMutableDictionary dictionary];
    //防止坐标混乱
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>7.0?YES:NO) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"mainCell"];
    _currpage=1;//默认请求页码为1
    _cityId=0;
    _latitude =23.13522 ;
    _longitude=113.2495;
    [self getResourceWithCity_ID:0 Page:_currpage Latitude:23.13522 andLongitude:113.2495];
    self.navigationItem.title=@"热门推荐";
    _leftItemBtn=[[UIBarButtonItem alloc]initWithTitle:@"未知" style:UIBarButtonItemStylePlain target:self action:@selector(selectCity:)];
    self.navigationItem.leftBarButtonItem=_leftItemBtn;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(selectCatogroy:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    //启动定位
    [self.locationManager startUpdatingLocation];
    
    self.mainTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //_currpage++;
        [self dragUpLoad];
        
        
    }];
}


#pragma mark---属性懒加载
-(UITableView*)mainTableView{
    if (!_mainTableView) {
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64) style:UITableViewStylePlain];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        
    }

    return _mainTableView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;

}
/*定位懒加载*/
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager=[[CLLocationManager alloc]init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        _locationManager.distanceFilter=1000.0f;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

#pragma mark---HTTPrequest
-(void)getResourceWithCity_ID:(NSInteger)city_id Page:(NSInteger)page Latitude:(double)latitude andLongitude:(double)longitude{
    NSString *urlString=@"http://api.lanrenzhoumo.com/main/recommend/index/";
    NSString *url=[urlString stringByAppendingString:[NSString stringWithFormat:@"?city_id=%ld&lat=%f&lon=%f&page=%ld&%@",city_id,latitude,longitude,page,Session_idAndV]];
    NSLog(@"url====%@\n\n\n\n\n",url);
   [AFNetworkingRequest getRequestWithUrl:url result:^(id result) {
       NSArray *array =result[@"result"];
       
       for (int i = 0 ; i < array.count; i++) {
           
           [self.dataSource addObject:array[i]];
       }
       [self.mainTableView reloadData];
       
   }];

}


#pragma mark----代理协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:MainCell forIndexPath:indexPath];
    MainSpaceModel *model=[[MainSpaceModel alloc]initWithDictinary:self.dataSource[indexPath.row ]];
    [cell setCellWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 400;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *dv=[[DetailViewController alloc]init];
    MainSpaceModel *model=[[MainSpaceModel alloc]initWithDictinary:self.dataSource[indexPath.row ]];
    dv.leo_id=[model.leo_id integerValue];
    NSLog(@"leo====%ld\n\n",[model.leo_id integerValue]);
    [self.navigationController pushViewController:dv animated:YES];



}

-(void)selectCity:(UIBarButtonItem*)sender{
    CityViewController *cv=[[CityViewController alloc]init];
    cv.delegate=self;
    NSString *str=self.leftItemBtn.title;
    cv.currentCity=str;
    //城市信息
    cv.currentCityDic=self.currCityDic;
    _currpage=1;
    [self.navigationController pushViewController:cv animated:YES];
}
//CityTableViewDelegate
-(void)sendSelectCityMasage:(NSDictionary *)dic{
    [self.dataSource removeAllObjects];
    _cityId=[dic[@"city_id"] integerValue];
    
    if (_cityId==0) {
        [self getResourceWithCity_ID:_cityId Page:_currpage Latitude:[dic[@"latitude"]floatValue] andLongitude:[dic[@"longitude"]floatValue]];
    }
    else{
        NSString *str=dic[@"city_name"];
        self.leftItemBtn.title=str;
        [self getLocationFromCityName:str];
        [self getResourceWithCity_ID:_cityId Page:_currpage Latitude:self.latitude andLongitude:self.longitude];
    }
    self.navigationItem.title=@"热门推荐";
}
//右侧导航栏按钮
-(void)selectCatogroy:(UINavigationItem*)item{
    
    if (!_isOpen) {
        
    _catogroyView=[[CatogroyView alloc]initWithFrame:CGRectMake(Width-20, 62, 10, 2)];
      [UIView animateWithDuration:0.5 animations:^{
       _catogroyView.frame=CGRectMake(5, 64+2,Width-10, 150);
       [_catogroyView setCatogroyBtn];
       _catogroyView.delegate=self;
         [self.view addSubview:_catogroyView];
        
                }];
       
        
       
        
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            [self.catogroyView removeFromSuperview];
        }];
    
    }
    _isOpen=!_isOpen;
    
    
}
//CatagroyView协议方法
-(void)selectCatogroyByButton:(CatagroyButton *)btn{
    //选择分区 从第一页开始请求
    _currpage=1;
    [self.dataSource removeAllObjects];
    //
    NSInteger tag=btn.nTag;
    NSString *categroy=btn.category;
    _currpage=1;
    self.navigationItem.title=btn.categroyName;
    if (tag==400) {
        [self getResourceWithCity_ID:_cityId Page:_currpage Latitude:self.latitude andLongitude:self.longitude];
    
    }
    else if (tag==402){
        NSLog(@"%ld",tag);
    }
    else{
        [self getCategroySourceWithCityId:_cityId Page:_currpage Latitude:self.latitude Longitude:self.longitude CategroyName:categroy andKeyWord:nil];
        
    }
    _isOpen=!_isOpen;
    self.navigationController.title=@"热门推荐";
    [self.catogroyView removeFromSuperview];
    
}
//分区数据请求
-(void)getCategroySourceWithCityId:(NSInteger)city_id Page:(NSInteger)page Latitude:(double)latitude Longitude:(double)longitude CategroyName:(NSString*)categroy andKeyWord:(NSString*)key {
    NSString *urlString=@"http://api.lanrenzhoumo.com/wh/common/leos";
    NSString *url=[urlString stringByAppendingString:[NSString stringWithFormat:@"?category=%@&city_id=%ld&keyword=&lat=%f&lon=%f&page=%ld&session_id=0000423f77528bee1b0655a91c1aaadf001096",categroy,city_id,latitude,longitude,page]];
    [AFNetworkingRequest getRequestWithUrl:url result:^(id result) {
        NSArray *array =result[@"result"];
        
        for (int i = 0 ; i < array.count; i++) {
            
            [self.dataSource addObject:array[i]];
        }

        [self.mainTableView reloadData];
        
    }];

}
/*定位协议 --在切换城市后需要停止定位 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    _currLocation=[locations  lastObject];
    _latitude=_currLocation.coordinate.latitude;
    _longitude=_currLocation.coordinate.longitude;
    NSLog(@"latitude==%lf",_currLocation.coordinate.latitude);
    NSLog(@"longitude==%lf",_currLocation.coordinate.longitude);
    //将当前城市的地理信息装入对应字典
     [_currCityDic setValue:@(_currLocation.coordinate.latitude)forKey:@"latitude"];
     [_currCityDic setValue:@(_currLocation.coordinate.longitude)forKey:@"longitude"];
   
    [self getCityMassage:_currLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"%@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status==kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"已经授权");
    }
    else if (status==kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"使用时授权");
    
    }
    else if (status==kCLAuthorizationStatusDenied){
        NSLog(@"拒绝");
    
    }
    else if (status==kCLAuthorizationStatusRestricted){
    
        NSLog(@"受限");
    }
    else if(status==kCLAuthorizationStatusNotDetermined){
    
        NSLog(@"用户还没确定");
    }
}
//定位方法，地理反编码
-(void)getLocationFromCityName:(NSString*)cityName{
    CLGeocoder *geocoder=[[CLGeocoder  alloc]init];
    [geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error=%@",error.localizedDescription);
        }
        else if (placemarks.count>0){
            
            CLPlacemark *placeMark=placemarks[0];
            
            CLLocation *location=placeMark.location;
            _longitude=location.coordinate.longitude;
            _latitude=location.coordinate.latitude;
        }
    }];
    
}
//地理编码
-(void)getCityMassage:(CLLocation*)currLocation{
    if (currLocation==nil) {
        self.leftItemBtn.title=@"未知";
    }
    else{
        CLGeocoder *geo=[[CLGeocoder alloc]init];
        [geo reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error is %@",error.localizedDescription);
            }
            else if(placemarks.count>0){
                CLPlacemark *placeMark=placemarks[0];
                NSString *currCityName=placeMark.locality;
            self.leftItemBtn.title=currCityName;
            [_currCityDic setValue:currCityName forKey:@"cityName"];
                
            }
        }];
  
    }


}

#pragma mark---刷新加载
-(void)dragUpLoad{
    _currpage++;
    
        NSString *urlString=@"http://api.lanrenzhoumo.com/main/recommend/index/";
        NSString *url=[urlString stringByAppendingString:[NSString stringWithFormat:@"?city_id=%ld&lat=%f&lon=%f&page=%ld&%@",self.cityId,self.latitude ,self.longitude,self.currpage ,Session_idAndV]];
        NSLog(@"%@\n\n\n\n\n\n\n\n\n\n",url);
        //当偏移量+屏幕款>=整个tableView的高时表示到了最低点
        [AFNetworkingRequest getRequestWithUrl:url result:^(id result) {
            NSLog(@"result = %@",result[@"result"]);
            
            NSArray *array =result[@"result"];
            
            for (int i = 0 ; i < array.count; i++) {
                
                [self.dataSource addObject:array[i]];
            }
            
            [self.mainTableView reloadData];
 
        }];
    
   
        
    [self.mainTableView.mj_footer endRefreshing];


}

-(void)dragDownRefreash{




}

-(void)updateData{
  




}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"contentOffset.y==%lf\n",scrollView.contentOffset.y+ScreenHeight);
//    NSLog(@"scrollView.contentSize.height+====%lf\n",scrollView.contentSize.height+20);
//    if (scrollView.contentOffset.y+ScreenHeight>=scrollView.contentSize.height+100){
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//           [self dragUpLoad];
//        });
//    
//    }
//}


@end

//
//  CityTableViewCell.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/1.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (nonatomic , copy) NSString              * province_name;
@property (nonatomic , copy) NSString              * city_name;
@property (nonatomic , strong) NSNumber            * city_id;
@property (nonatomic , strong) NSNumber            * province_id;
@property(nonatomic,strong)NSMutableArray          *cityArray;

//-(void)setModel:(id)model;






@end

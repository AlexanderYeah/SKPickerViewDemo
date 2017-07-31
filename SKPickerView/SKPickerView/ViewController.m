//
//  ViewController.m
//  SKPickerView
//
//  Created by AY on 2017/7/31.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>


/** pickerView */
@property (nonatomic,strong)UIPickerView *pickerView;
/** 当前默认选中的省份 */
@property (nonatomic,assign)NSInteger indexOfProvince; // 不给赋值，默认就是0
/** 所有省份字典 */
@property (nonatomic,strong)NSDictionary *cityNames;
/** 所有省份数组 */
@property (nonatomic,strong)NSArray *provinces;
/** 所有城市数组 */
@property (nonatomic,strong)NSArray *citys;
/** 显示label */
@property (nonatomic,strong)UILabel *showLBl;
@end

@implementation ViewController

#pragma mark - 0 懒加载
/**
0 城市的名字
*/
- (NSDictionary *)cityNames
{
    if (!_cityNames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityData.plist" ofType:nil];
		_cityNames = [NSDictionary dictionaryWithContentsOfFile:path];
		
		
    }
    return _cityNames;
}

/**
省份
*/
- (NSArray *)provinces{
	if (!_provinces) {
	
    _provinces = [self.cityNames allKeys];
	}
	return _provinces;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.indexOfProvince = 0;
	UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 375, 300)];
	picker.delegate = self;
	picker.dataSource = self;
	[self.view addSubview:picker];
	_pickerView = picker;
	
	
	
	_showLBl = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 250, 35)];
	_showLBl.textColor = [UIColor blackColor];
	[self.view addSubview:_showLBl];
	
	
	// 获取picker 的选中内容
	NSInteger index_1 = [self.pickerView selectedRowInComponent:0];
	NSInteger index_2 = [self.pickerView selectedRowInComponent:1];
	NSString *selectedProviceStr = self.provinces[index_1];
	NSString *selCityStr = [self.cityNames valueForKey:selectedProviceStr][index_2];
	
	_showLBl.text = [NSString stringWithFormat:@"所在地:    %@  %@",selectedProviceStr,selCityStr];

}



/** 返回数量 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (component == 0) {
	// 第一列数据 返回省份列表
		return self.provinces.count;
	}else{
	// 返回城市列表 默认返回北京的数据
		self.citys = [self.cityNames valueForKey:self.provinces[self.indexOfProvince]];
		return self.citys.count;
	}

}
/** 返回每一行的文本 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (component == 0) {
		return self.provinces[row];
	}else{
		
		self.citys = [self.cityNames valueForKey:self.provinces[self.indexOfProvince]];
		return self.citys[row];
	}

}
/** 返回多少列 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

/** 选中联动 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == 0) {
	// 第一列滑动联动第二列
		self.indexOfProvince = row;
		[pickerView reloadComponent:1];
	}
	
}





- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end

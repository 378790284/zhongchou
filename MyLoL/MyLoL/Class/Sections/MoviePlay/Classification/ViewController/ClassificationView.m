//
//  ClassificationView.m
//  MyLoL
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

//http://box.dwstatic.com/apiVideoesNormalDuowan.php?sn=&pn=&OSType=iOS8.4&v=117&action=c
//

#import "ClassificationView.h"
#import "UIViewAdditions.h"
#import "NetWorkEngine.h"
#import "SectionCell.h"
#import "NewVideoController.h"

@interface ClassificationView ()<UITableViewDelegate,UITableViewDataSource,NetWorkProtrol,SectionCellDelegate>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NetWorkEngine *engine;
@property (nonatomic,strong)NSMutableArray *sectionNameArray;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ClassificationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height - 113);
    self.navigationController.navigationBar.translucent = NO;
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.left, self.view.top , self.view.width, self.view.height)];
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    [self.view addSubview:self.aTableView];
    [self loadNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadNewData
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?sn=&pn=&OSType=iOS8.4&v=117&action=c"];
    _engine.delegate = self;
    [_engine getArray:urlString];
}

//  接口请求成功
- (void)netWorkDidSuccessfulBackArray:(NSArray *)array
{
    //NSLog(@"%@",array);
    for (NSDictionary *perSection in array) {
        NSString *perName = [perSection objectForKey:@"name"];
        [self.sectionNameArray addObject:perName];
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:array];
//    NSLog(@"%@", self.dataArray);
    
    //NSLog(@"%@", self.sectionNameArray);
    
    [self.aTableView reloadData];
}

//  接口请求失败
- (void)netWorkDidFail:(NSError *)error
{
    
}


// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionNameArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionNameArray[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIndentifier = @"cell";
    SectionCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIndentifier];
//    cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    [cell addCellForArray:self.dataArray[indexPath.section]];
    cell.delegate = self;
    //[self.aTableView reloadData];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 100;
    }
    else if (indexPath.section == 1)
    {
        return 600;
    }
    else if (indexPath.section == 2)
    {
        return 200;
    }
    else if (indexPath.section == 3)
    {
        return 200;
    }
    return 400;
}

- (NSMutableArray *)sectionNameArray
{
    if (_sectionNameArray == nil) {
        self.sectionNameArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _sectionNameArray;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}

- (void)pushotherVC:(NSString *)str
{
    NewVideoController *newVideoVC = [[NewVideoController alloc]init];
    newVideoVC.pushTag = str;
    [self.navigationController pushViewController:newVideoVC animated:YES];
//    NSLog(@"%@",str);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

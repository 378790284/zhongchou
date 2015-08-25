//
//  DownLoadTable.m
//  MyLoL
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DownLoadTable.h"
#import "Define.h"

@interface DownLoadTable ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *aTableView;

@end

@implementation DownLoadTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.aTableView];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}


- (UITableView *)aTableView
{
    if (_aTableView == nil) {
        self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
    }
    return _aTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

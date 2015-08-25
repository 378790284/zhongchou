//
//  SetViewController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SetViewController.h"
#import "UIViewAdditions.h"
#import "CollectionViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *aTableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.aTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)aTableView
{
    if (_aTableView == nil) {
        self.aTableView = [ [UITableView alloc]initWithFrame:CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height) style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        
    }
    return _aTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CollectionViewController *collectionVC = [[CollectionViewController alloc]init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
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

//
//  CollectionViewController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
//    [dic setValue:movieTitle forKey:@"movieTitle"];
//    [dic setValue:movieUrl forKey:@"movieUrl"];
//    [dic setValue:movieTime forKey:@"movieTime"];
//    [dic setValue:movieImage forKey:@"movieImage"];
//    [dic setValue:movieUpDate forKey:@"movieUpDate"];


#import "CollectionViewController.h"
#import "FmdbModel.h"
#import "UIViewAdditions.h"
#import "Define.h"
#import "NewVideoCell.h"
#import "HouMoviePlayerViewController.h"

@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aTableView];
    self.dataArray = [NSMutableArray arrayWithArray:[[FmdbModel alloc] getAll]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(enitTableView:)];
}



#pragma mark -- 删除编辑
//删除按钮
- (void)enitTableView:(UIBarButtonItem *)barButtonItem
{
    if (_aTableView.editing) {
        barButtonItem.title = @"编辑";
    }
    else
    {
        barButtonItem.title = @"完成";
    }
    
    [_aTableView setEditing:!_aTableView.editing animated:YES];
}

// 哪些行可以被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 指定编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// 开始编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        NSDictionary *dic = self.dataArray[indexPath.row];
        NSString *movieTitle = [dic objectForKey:@"movieTitle"];
        [[FmdbModel shareFmdb]deleData:movieTitle];
        [self.dataArray removeObject:dic];
        //删除时的编辑样式
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        
    }
}

//指定删除单元格的按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除收藏";
}

#pragma mark -- 收藏表格的制作
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// 自定义单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    NewVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[NewVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    NSDictionary *dic = (NSDictionary *)self.dataArray[indexPath.row];
    NSString *movieTitle = [dic objectForKey:@"movieTitle"];
    NSString *movieTime = [dic objectForKey:@"movieTime"];
    NSString *movieImage = [dic objectForKey:@"movieImage"];
    NSString *movieUpDate = [dic objectForKey:@"movieUpDate"];
    
    [cell.collectButton setTitle:@"取消收藏" forState:UIControlStateNormal];
    [cell.collectButton addTarget:self action:@selector(collectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.collectButton.tag = 1000 + indexPath.row;
    
    [cell collectionVideo:movieTitle movieTime:movieTime movieImage:movieImage movieUpdate:movieUpDate];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

// 选择跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


// 点击取消 删除响应事件
- (void)collectionButtonAction:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    NSDictionary *dic = self.dataArray[sender.tag - 1000];
    NSString *movieTitle = [dic objectForKey:@"movieTitle"];
    [[FmdbModel shareFmdb]deleData:movieTitle];
    [self.dataArray removeObject:dic];
    [self.aTableView reloadData];
}


- (UITableView *)aTableView
{
    if (_aTableView == nil) {
        self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height) style:UITableViewStylePlain];
        self.aTableView.delegate = self;
        self.aTableView.dataSource = self;
        
    }
    return _aTableView;
}

// 返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_SCREEN_HEIGHT / 7;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
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

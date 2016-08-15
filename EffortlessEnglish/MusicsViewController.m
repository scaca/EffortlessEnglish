//
//  MusicsViewController.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/12.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "MusicQueue.h"
#import "MusicsViewController.h"
#import "PDFShowViewController.h"

@interface MusicsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *songsArray;

@end

static NSString *CellIdentifier = @"CellIdentifier";

@implementation MusicsViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Effortless English";
    self.songsArray = [[MusicQueue defaultInstance] musicList];
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDFShowViewController *pdfShowVC = [[PDFShowViewController alloc] init];
    pdfShowVC.musicName = [self.songsArray objectAtIndex:indexPath.row];
    [[MusicQueue defaultInstance] setupCurrentMusic:indexPath.row];
//    [self.navigationController pushViewController:pdfShowVC animated:YES];

    [self presentViewController:pdfShowVC animated:YES completion:nil];
}

#pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *songName = [self.songsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:songName];
    return cell;
}

#pragma mark Private methods

- (void)initTableView {
    // Init TableView
    UITableView *tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        tableView;
    });
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
    }];
    self.tableView = tableView;
}
@end

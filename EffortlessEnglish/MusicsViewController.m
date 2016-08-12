//
//  MusicsViewController.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/12.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicsViewController.h"

@interface MusicsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<NSString *> *songsArray;

@end

static NSString *CellIdentifier = @"CellIdentifier";

@implementation MusicsViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Effortless English";
    [self initMusicList];
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
    MusicPlayerViewController *musicPlayerVC = [[MusicPlayerViewController alloc] init];
    musicPlayerVC.musicName = [self.songsArray objectAtIndex:indexPath.row];
    [self.navigationController presentViewController:musicPlayerVC
                       animated:YES
                     completion:^{

                     }];
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

- (void)initMusicList {
    self.songsArray = @[].mutableCopy;
    NSArray<NSString *> *songNameArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:nil];

    for (NSString *fullPath in songNameArray) {
        NSString *mp3FileName = [self resolveNameFromFullPath:fullPath];
        if (mp3FileName) {
            NSLog(@"mp3 file name is %@", mp3FileName);

            [self.songsArray addObject:mp3FileName];
        }
    }
}

/*
 Mp3 file full path like below
 "/Users/wangyuehong/Library/Developer/CoreSimulator/Devices/B15E1CA0-EAB2-425D-A64A-16CB18180CD8/data/Containers/Bundle/Application/29AFF741-975A-4661-8FF0-B4FF348AC69A/EffortlessEnglish.app/03-TheWeddingVocabulary.mp3"
 */
- (NSString *)resolveNameFromFullPath:(NSString *)path {
    if (!path) {
        return nil;
    }
    NSArray *tempArray = [path componentsSeparatedByString:@"/"];
    if (tempArray.count <= 0) {
        return nil;
    }
    NSString *mp3Name = [tempArray lastObject];
    tempArray = [mp3Name componentsSeparatedByString:@"."];
    return [tempArray firstObject];
}

@end

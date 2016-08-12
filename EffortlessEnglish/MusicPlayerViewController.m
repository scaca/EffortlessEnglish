//
//  MusicPlayerViewController.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/12.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MusicPlayerViewController.h"
#import "PDFShowView.h"

@interface MusicPlayerViewController ()
@property(nonatomic, strong) NSURL *musicURL;
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerItem *playerItem;
@property(nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation MusicPlayerViewController

#pragma mark - UIViewController

- (void)setupDictionary {
    self.dictionary = @{
        @"Day of the Dead Audio" : @"Day of the Dead",
        @"Day of the Dead MS" : @"Day of the Dead",
        @"Day of the Dead Vocab" : @"Day of the Dead",
        @"A Kiss Audio" : @"A Kiss Text",
        @"A Kiss MS-A" : @"A Kiss Text",
        @"A Kiss MS-B" : @"A Kiss Text",
        @"A Kiss Vocab" : @"A Kiss Text",
        @"Bubba's Food Audio" : @"Bubbas Food Text",
        @"Bubba's Food MS-A" : @"Bubbas Food Text",
        @"Bubba's Food MS-B" : @"Bubbas Food Text",
        @"Bubba's Food MS-C" : @"Bubbas Food Text",
        @"Bubba's Food Vocab" : @"Bubbas Food Text",
        @"Changed Audio" : @"Changed",
        @"Changed MS-A" : @"Changed",
        @"Changed MS-B" : @"Changed",
        @"Changed Vocab" : @"Changed",
        @"Drag Audio" : @"Drag",
        @"Drag MS-A" : @"Drag",
        @"Drag MS-B" : @"Drag",
        @"Drag Vocab" : @"Drag",
        @"Intimacy Audio" : @"Intimacy Text",
        @"Intimacy MS-A" : @"Intimacy Text",
        @"Intimacy MS-B" : @"Intimacy Text",
        @"Intimacy Vocab" : @"Intimacy Text",
        @"Secret Love Audio" : @"Secret Love",
        @"Secret Love MS-A" : @"Secret Love",
        @"Secret Love MS-B" : @"Secret Love",
        @"Secret Love Vocab" : @"Secret Love",
    };
}
- (void)showPDFView {
    NSString *phrase = nil;  // Document password (for unlocking most encrypted PDF files)

    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.musicName ofType:@"pdf"];

    if (!filePath) {
        // 根据musicName 获取PDF文件名
        filePath = [[NSBundle mainBundle] pathForResource:self.dictionary[self.musicName] ofType:@"pdf"];
    }

    LazyPDFDocument *document = [LazyPDFDocument withDocumentFilePath:filePath password:phrase];
    PDFShowView *pdfshowView = [[PDFShowView alloc] initWithLazyPDFDocument:document];
    [self.view addSubview:pdfshowView];
    [pdfshowView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(self.view);
      make.bottom.equalTo(self.view).offset(50);
    }];
}

- (void)setupAVPlayer {
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];

    self.musicURL = [[NSBundle mainBundle] URLForResource:self.musicName withExtension:@"mp3"];
    self.playerItem = [AVPlayerItem playerItemWithURL:self.musicURL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];

    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    layer.frame = CGRectMake(0, kScreen_Height - 50, kScreen_Width, 50);
    layer.backgroundColor = [[UIColor grayColor] CGColor];
    [self.view.layer addSublayer:layer];

    [self.player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupDictionary];
    [self setupAVPlayer];

    [self showPDFView];

    [self setupCancelButton];
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

- (void)setupCancelButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cllickHandler) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)cllickHandler {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

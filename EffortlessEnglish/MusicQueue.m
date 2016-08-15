//
//  MusicQueue.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/14.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "MusicQueue.h"

@interface MusicQueue ()

@property(nonatomic, strong) NSMutableArray<NSString *> *songsArray;

@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation MusicQueue

kSingleton_Implementation(MusicQueue);

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray<NSString *> *songNameArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:nil];

        self.songsArray = @[].mutableCopy;
        for (NSString *fullPath in songNameArray) {
            NSString *mp3FileName = [self resolveNameFromFullPath:fullPath];
            if (mp3FileName) {
                NSLog(@"mp3 file name is %@", mp3FileName);

                [self.songsArray addObject:mp3FileName];
            }
        }
    }
    return self;
}

- (NSArray *)musicList {
    return self.songsArray;
}

- (void)setupCurrentMusic:(NSInteger)index {
    self.currentIndex = index;
}

- (NSString *)currentMusic {
    return self.songsArray[self.currentIndex];
}

- (NSString *)prevMusic {
    if (self.currentIndex > 0) {
        self.currentIndex -= 1;
    } else {
        self.currentIndex = self.songsArray.count - 1;
    }
    return self.songsArray[self.currentIndex];
}

- (NSString *)nextMusic {
    if (self.currentIndex < self.songsArray.count - 1) {
        self.currentIndex += 1;
    } else {
        self.currentIndex = 0;
    }
    return self.songsArray[self.currentIndex];
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

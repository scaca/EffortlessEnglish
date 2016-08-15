//
//  MusicQueue.h
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/14.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicQueue : NSObject

kSingleton_Interface(MusicQueue);

- (NSArray*)musicList;

- (void)setupCurrentMusic:(NSInteger)index;

- (NSString*)currentMusic;

- (NSString*)prevMusic;

- (NSString*)nextMusic;

@end

//
//  ViewController.m
//  PlayMusicDemo
//
//  Created by 千锋 on 16/3/23.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
//Audio/Video
//UIFoundation
//UIKit
//MK Mapkit

@interface ViewController ()<AVAudioPlayerDelegate>

@property (nonatomic,strong)AVAudioPlayer * audioPlayer;
//音频播放
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMusic];
}

//播放音乐
-(void)playMusic{
    
    //音乐文件路径
    NSURL *musicURL=[[NSBundle mainBundle] URLForResource:@"月半小夜曲" withExtension:@"mp3"];
    NSLog(@"%@",[NSBundle mainBundle]);
    NSLog(@"%@",NSHomeDirectory());
    //
    NSError *error;
    //创建播放器 一个音频文件对应一个播放器对象
    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
    //设置委托
    self.audioPlayer.delegate=self;
    if (!error) {
        //准备播放
        BOOL isPrepare=[self.audioPlayer prepareToPlay];
        if (isPrepare)
        {
            //播放
            [self.audioPlayer play];
        }else{
            NSLog(@"没准备好");
        }
        
    }else{
        NSLog(@"创建失败 %@",error.localizedDescription);
        
    }
    //读取音频文件的信息
    //资源信息
    AVURLAsset *asset=[AVURLAsset assetWithURL:musicURL];
//    //读资源信息
//    AVAssetReader *reader=[[AVAssetReader alloc] initWithAsset:asset error:&error];
//    //开始读取音频文件的信息
//    [reader startReading];
//    
//  CMTimeRange range=reader.timeRange;
//
//    NSLog(@"start %lld",range.start.value);
//    
    //获取音频文件中所有元数据信息
    NSArray *metaDataArray=[asset availableMetadataFormats];
    NSLog(@"%@",metaDataArray);
    
    for (NSString *metaDataStr in metaDataArray) {
        //按照metaData读取条目信息
        NSArray *metaDataItems=[asset metadataForFormat:metaDataStr];
        for (AVMetadataItem *item in metaDataItems) {
            NSLog(@"metadata key=%@ value %@",item.commonKey,item.value);
            NSString * key=[NSString stringWithFormat:@"%@",item.key];
            //找到音频文件标题
            if ([key isEqualToString:@"TIT2"]) {
                NSLog(@"歌曲名称 %@",item.value);
            }
        }
        
    }
    
    
    
}

#pragma mark -AVAudioPlayerDelegate

//播放音频结束
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放音频结束");
    
    
}
//当播放音频时 出现编码错误时回调
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    
    NSLog(@"%@",error.localizedDescription);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

import 'package:flutter/material.dart';
import 'package:fijkplayer_ijkfix/fijkplayer_ijkfix.dart';
import 'skin/schema.dart' show VideoSourceFormat;
import 'package:flutter/services.dart';

import 'skin/fijkplayer_skin.dart';

 //这里实现一个皮肤显示配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = true;  // 是否显示剧集按钮
  @override
  bool nextBtn = true;    // 是否显示下一集按钮
  @override
  bool speedBtn = true;   // 是否显示速度按钮
  @override
  bool topBar = true;     // 是否显示播放器状态栏（顶部），非系统
  @override
  bool lockBtn = true;    // 是否显示锁按钮
  @override
  bool autoNext = true;   // 播放完成后是否自动播放下一集，false 播放完成即暂停
  @override
  bool bottomPro = true;  // 底部吸底进度条，贴底部，类似开眼视频
  @override
  bool stateAuto = false;  // 是否自适应系统状态栏，true 会计算系统状态栏，从而加大 topBar 的高度，避免挡住播放器状态栏
  @override
  bool isAutoPlay = true; // 是否自动开始播放
}


class FijkVideoPage extends StatefulWidget {
  FijkVideoPage();
  @override
  _FijkVideoPageState createState() => _FijkVideoPageState();
}

class _FijkVideoPageState extends State<FijkVideoPage> {
  //  视频测试链接 ：
  //  https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4

  //  音频测试链接：
  //  http://downsc.chinaz.net/Files/DownLoad/sound1/201906/11582.mp3
  // FijkPlayer实例
  final FijkPlayer player = FijkPlayer();
  // 当前tab的index，默认0
  int _curTabIdx = 0;
  // 当前选中的tablist index，默认0
  int _curActiveIdx = 0;
  ShowConfigAbs vCfg = PlayerShowConfig();
  // 视频源列表，请参考当前videoList完整例子
  Map<String, List<Map<String, dynamic>>> videoList = {
    "video": [
      {
        "name": "武汉加油",
        "list": [
          {
            //  rtmp : rtmp://58.200.131.2:1935/livetv/dftv
            //  connection refused
           "url": "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4",
//            "name": "rtsp视频测试"
            "name": "视频测试1"
          },
          {
            "url": "https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218093206z8V1JuPlpe.mp4",
            "name": "视频测试2"
          },
          {
            "url": "https://stream7.iqilu.com/10339/article/202002/18/2fca1c77730e54c7b500573c2437003f.mp4",
            "name": "视频测试3"
          }
        ]
      },
      {
        "name": "中国加油",
        "list": [
          {
            "url": "https://n1.szjal.cn/20210428/lsNZ6QAL/index.m3u8",
            "name": "m3u8测试视频"
          },
          {
            "url": "https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218025702PSiVKDB5ap.mp4",
            "name": "中国加油1"
          },
          {
            "url": "http://stream4.iqilu.com/ksd/video/2020/02/17/c5e02420426d58521a8783e754e9f4e6.mp4",
            "name": "中国加油2"
          }
        ]
      },
    ]
  };

  VideoSourceFormat? _videoSourceTabs;

  @override
  void initState() {
    super.initState();
    //  支持单页面的横竖屏，记得dispose的时候设置会竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    setPlayerOptions();
    // 格式化json转对象
    _videoSourceTabs = VideoSourceFormat.fromJson(videoList);
    // 这句不能省，必须有
    speed = 1.0;
  }

  //  初始化一些player的配置
  void setPlayerOptions() async {
    //  设置常亮
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    //  android下的音频Audio Focus
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1)
        .catchError((error){
      print("setDataSource error: $error");
    });
  }

  //  释放player
  @override
  void dispose() {
    print("video ~~ dispose  to release palyer and setPreferredOrientations!!!");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    player.dispose();
    super.dispose();
  }

  // 播放器内部切换视频钩子，回调，tabIdx 和 activeIdx
  void onChangeVideo(int curTabIdx, int curActiveIdx) {
    this.setState(() {
      _curTabIdx = curTabIdx;
      _curActiveIdx = curActiveIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("FijkVideo Page")),
        body: OrientationBuilder(// 监测手机旋转状态的小部件
            builder: (context, orientation) {
              return  Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      // 这里 FijkView 开始为自定义 UI 部分
                      child: FijkView(
                        height: orientation == Orientation. portrait ?260:MediaQuery.of(context).size.height,
                        color: Colors.black,
                        fit: FijkFit.cover,
                        player: player,
                        panelBuilder: (
                            FijkPlayer player,
                            FijkData data,
                            BuildContext context,
                            Size viewSize,
                            Rect texturePos,
                            ) {
                          /// 使用自定义的布局
                          return CustomFijkPanel(
                            player: player,
                            // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
                            // 如果要点击箭头关闭当前的页面，那必须传递当前组件的根 context
                            pageContent: context,
                            viewSize: viewSize,
                            texturePos: texturePos,
                            // 标题 当前页面顶部的标题部分，可以不传，默认空字符串
                            playerTitle: "标题",
                            // 当前视频改变钩子，简单模式，单个视频播放，可以不传
                            onChangeVideo: onChangeVideo,
                            // 当前视频源tabIndex
                            curTabIdx: _curTabIdx,
                            // 当前视频源activeIndex
                            curActiveIdx: _curActiveIdx,
                            // 显示的配置
                            showConfig: vCfg,
                            // json格式化后的视频数据
                            videoFormat: _videoSourceTabs,
                          );
                        },
                      )
                  ),
                  const SizedBox(height: 30,),
                  RawMaterialButton(onPressed: (){
                    player.resetPlayerUrl("https://iptvbox.smgtech.net:8080/live/ics.m3u8");
                  },
                  child: const Text("change~~"),),
                  const SizedBox(height: 30,),
                  RawMaterialButton(onPressed: (){
                    player.resetPlayerUrl("");
                  },
                    child: const Text("change1111~~"),)
                ],
              );

            })
    );
//    )
  }


}



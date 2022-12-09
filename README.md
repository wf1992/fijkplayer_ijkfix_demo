# fijkplayer_ijkfix
# 请使用0.0.9或者往上的版本，0.0.5也可以
0.0.9支持了iOS下的动态更换播放源url的功能。

此项目是依赖于fijkplayer的插件的衍生产物，修复了fijkplayer的不支持wav，s48等音频格式等问题。。

## 项目介绍：

fijkplayer_ijkfix -> fijkplayer -> ijkplayer(befovy:https://github.com/befovy/ijkplayer.git) -> ijkplayer

-> 代表依赖于


若想自己去编译ijkplayer（befovy） ，需要去按照他的action 去编译： https://github.com/befovy/ijkplayer/actions/runs/156246096/workflow


## 编译ijkplayer的流程：

cd 自己喜欢的文件夹。。。

git clone https://github.com/befovy/ijkplayer.git ijkplayer-ios

cd ijkplayer-ios

# 修改 ios 文件夹下的 module.sh ，在里面添加自己需要新增的编解码格式
# 如s48音频需要的：
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=mpeg4"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=mp2*"
# export COMMON_FF_CFG_FLAGS="$COMMON_FF_CFG_FLAGS --enable-decoder=ac3"

# 再执行：

bash init-ios-openssl.sh

bash init-ios.sh

cd ios 

# 再执行：

bash compile-openssl.sh all

bash compile-ffmpeg.sh all

# 最后在IJKMediaDemo中去查询IJKMediaPlayer.framework 的产物，丢到fijkplayer_ijkfix -> ios -> Frameworks中去
 


# 顺便说一句：这个plugin依旧支持fijkplayer_skin。

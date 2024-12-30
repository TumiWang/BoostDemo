# 第三方库

这个环境目前有openssl和boost，都是使用源码编译的
编译后在prefix目录下
首次使用时，需要使用reinstall_third_party这个脚本对第三方库进行编译

reinstall_third_party.sh脚本运行时间较长
MacOS平台为防止休眠等可以使用下面脚本
```
caffeinate -dims ./reinstall_third_party.sh
```

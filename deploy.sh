#!/usr/bin/env bash

# 停止正在运行的所有进程函数
# 通过nginx配置8080端口来访问vue项目
killJavaTask(){
    pid=`netstat -anp|grep 8080|awk '{print $7}'|cut -d/ -f1`
    echo "server alive at pid :$pid"
    if [ "$pid" = "" ]
    then
        echo "no server pid alive"
    else
        kill -9 $pid
        echo "kill server pid success:$pid"
    fi
}

# 进入项目根目录
cd $PROJ_PATH

# 编译vue项目生成dist静态文件
npm run build

# 删除之前的项目
rm -rf /root/data/www/*

# 将生成的dist静态文件复制到项目目录
cp -rf dist /root/data/www/

# 进入nginx路径重启nginx
cd /usr/local/nginx
./sbin/nginx -s reload
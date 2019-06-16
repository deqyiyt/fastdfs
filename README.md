### 执行启动单机版fastdfs
```shell
docker run \
-d \
# 宿主机IP地址，可以是内网或者外网，只要能访问到
-e FASTDFS_IPADDR=192.168.1.100 \
-p 8888:8888 \
-p 22122:22122 \
-p 23000:23000 \
-v /data/fastdfs/tracker:/fastdfs/tracker \
-v /data/fastdfs/storage:/fastdfs/storage \
--name fastdfs \
fishkj/fastdfs:5.11
```

### 执行启动storage
```shell
docker run \
-d \
# 宿主机IP地址，可以是内网或者外网，只要能访问到
-e FASTDFS_IPADDR=192.168.1.100 \
-e SERVER=STORAGE \
-p 8888:8888 \
-p 23000:23000 \
#-v conf/mod_fastdfs.conf:/etc/fdfs/mod_fastdfs.conf
#-v conf/storage.conf:/etc/fdfs/storage.conf
#-v conf/client.conf:/etc/fdfs/client.conf
-v /data/fastdfs/storage:/fastdfs/storage \
--name fish.storage \
fishkj/fastdfs:5.11
```


### 执行启动tracker
```shell
docker run \
-d \
-e SERVER=TRACKER \
-p 22122:22122 \
#-v conf/tracker.conf:/etc/fdfs/tracker.conf
-v /data/fastdfs/tracker:/fastdfs/tracker \
--name fish.tracker \
fishkj/fastdfs:5.11
```

### 环境变量
* FASTDFS_IPADDR：追踪器的IP地址，只要容器内能访问到即可  
* SERVER  
> ALL：单节点  
> STORAGE：存储仓库  
> TRACKER：跟踪器  

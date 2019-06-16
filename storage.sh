# 执行启动storage
# 集群 -v conf:/etc/fdfs
#		重写mod_fastdfs.conf  storage.conf  client.conf
#	
docker run \
-d \
-e FASTDFS_IPADDR=172.19.81.154 \
-e SERVER=STORAGE \
-p 8888:8888 \
-p 23000:23000 \
-v /data/fastdfs/storage:/fastdfs/storage \
--name fish.storage \
fishkj/fastdfs:5.11

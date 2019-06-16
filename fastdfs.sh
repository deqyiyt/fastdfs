docker run \
-d \
--network host \
-e FASTDFS_IPADDR=172.19.81.154 \
-v /data/fastdfs/tracker:/fastdfs/tracker \
-v /data/fastdfs/storage:/fastdfs/storage \
-v /etc/localtime:/etc/localtime:ro \
--name fish.fastdfs \
fishkj/fastdfs:5.11

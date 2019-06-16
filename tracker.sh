# 执行启动tracker
# 集群高可用 修改 tracker.conf

docker run \
-d \
-e SERVER=TRACKER \
-p 22122:22122 \
-v /data/fastdfs/tracker:/fastdfs/tracker \
--name fish.tracker \
fishkj/fastdfs:5.11

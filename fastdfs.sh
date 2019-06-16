#!/bin/bash

if [ $FASTDFS_IPADDR ]; then
	old="com.ikingtech.ch116221"

	sed -i "s/$old/$FASTDFS_IPADDR/g" /etc/fdfs/client.conf
	sed -i "s/$old/$FASTDFS_IPADDR/g" /etc/fdfs/storage.conf
	sed -i "s/$old/$FASTDFS_IPADDR/g" /etc/fdfs/mod_fastdfs.conf
fi

mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.t
cp /etc/fdfs/nginx.conf /usr/local/nginx/conf

if [ ! -d "/usr/local/lib/libfastcommon.so" ]; then
	ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
fi

if [ ! -d "/usr/lib/libfastcommon.so" ]; then
	ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
fi

if [ ! -d "/usr/local/lib/libfdfsclient.so" ]; then
	ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
fi

if [ ! -d "/usr/lib/libfdfsclient.so" ]; then
	ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so
fi

if [ ! -d "/fastdfs/storage/data/M00" ]; then
	ln -s /fastdfs/storage/data/ /fastdfs/storage/data/M00
fi

if [ "$SERVER" = "TRACKER" ]; then
	echo "start trackerd"
	/etc/init.d/fdfs_trackerd start
	tail -f /fastdfs/tracker/logs/trackerd.log
elif [ "$SERVER" = "STORAGE" ]; then
	echo "start storage"
	/etc/init.d/fdfs_storaged start
	echo "start nginx"
	/usr/local/nginx/sbin/nginx 
	tail -f /fastdfs/storage/logs/storaged.log
elif [ "$SERVER" = "ALL" ]; then
	echo "start trackerd"
	/etc/init.d/fdfs_trackerd start
	echo "start storage"
	/etc/init.d/fdfs_storaged start
	echo "start nginx"
	/usr/local/nginx/sbin/nginx
	tail -f /fastdfs/storage/logs/storaged.log
else
	exit 1
fi

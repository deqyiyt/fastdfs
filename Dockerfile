FROM centos:7.6.1810

# 添加配置文件
# add profiles
ADD conf/* /etc/fdfs/
ADD fastdfs.sh /home

# 添加源文件
# add source code
ADD source/* /usr/local/src/

# 下载依赖及安装应用程序
RUN yum install -y gcc gcc-c ++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel \
	&& cd /usr/local/src/libfastcommon-1.0.39 \
		&& ./make.sh && ./make.sh install \
	&& cd /usr/local/src/fastdfs-5.11 \
		&& ./make.sh && ./make.sh install \
	&& cd /usr/local/src/nginx-1.15.4 \
		&& ./configure --add-module=/usr/local/src/fastdfs-nginx-module-1.20/src \
		&& make && make install \
	&& rm -rf /usr/local/src/*

# 设置挂载目录
VOLUME ["/etc/fdfs", "/fastdfs/storage", "/fastdfs/tracker"]

# 配置环境变量
ENV SERVER ALL

# 设置端口
EXPOSE 22122 23000 8888

# 设置工作目录
WORKDIR /fastdfs

ENTRYPOINT ["sh","/home/fastdfs.sh"]
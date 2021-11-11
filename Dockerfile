FROM centos:7
COPY techtrainingcamp-AppUpgrade /root/server
COPY ./public/index.html /root/public/index.html
EXPOSE 8080
EXPOSE 11451
ENV IS_DOCKER 1
RUN  mysql -e "CREATE DATABASE app;"&&\ 
    mysql -e "CREATE USER 'test'@'localhost' IDENTIFIED BY '123456';"&&\
    mysql -e "grant all privileges on *.* to 'test'@'%' identified by '123456' WITH GRANT OPTION ;"&&\  
    mysql -e "grant all privileges on *.* to 'test'@'localhost' identified by '123456' WITH GRANT OPTION ;"&&\ 
    mysql -u test -p123456 -e "use app;
CREATE TABLE rules(
    id int UNSIGNED AUTO_INCREMENT,
    aid INT UNSIGNED,
    hit_count INT UNSIGNED DEFAULT 0,
    download_count INT UNSIGNED DEFAULT 0,  
    platform CHAR(16),
    download_url VARCHAR(128),
    update_version_code	VARCHAR(128),
    device_list TEXT,
    md5	VARCHAR(128),
    max_update_version_code	VARCHAR(128),
    min_update_version_code	VARCHAR(128),
    max_os_api	TINYINT UNSIGNED,
    min_os_api	TINYINT UNSIGNED,
    cpu_arch	TINYINT UNSIGNED,
    channel	VARCHAR(128),
    title	VARCHAR(256),
    update_tips	VARCHAR(1024),
    enabled	BOOLEAN DEFAULT true,
	create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ( id )
);"  
CMD /root/server

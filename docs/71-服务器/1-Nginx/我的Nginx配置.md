# 我的Nginx配置

仅供参考

```
user			root;
worker_processes	1;

events {
	worker_connections	1024;
}

http {
	include				mime.types;
	include				vhost/*.conf;
	default_type			application/octet-stream;
	sendfile			on;
	client_max_body_size		100M;
	keepalive_timeout		60;

	ssl_certificate			/root/nginx/ssl/wangshaogang.com_chain.crt;
	ssl_certificate_key		/root/nginx/ssl/wangshaogang.com_key.key;

	server {
		listen			80;
		server_name		*.wangshaogang.com;
		rewrite ^(.*)$		https://$host$1 permanent;
	}

	server {
		listen			443 ssl;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}

	server {
		listen			443 ssl;
		server_name		www.wangshaogang.com wangshaogang.com;
		if ($http_host ~ "^wangshaogang.com$") {
                	rewrite  ^(.*)    https://www.wangshaogang.com$1 permanent;
		}
       		location / {
			proxy_pass	http://www.wangshaogang.com:12080;
			proxy_set_header Accept-Encoding "";
			sub_filter_once	off;
			sub_filter  'http://' 'https://';
			sub_filter  'http:\/\/' 'https:\/\/';
			sub_filter  'wangshaogang.com:12080' 'wangshaogang.com';
			sub_filter  'wangshaogang.com%3A12080' 'wangshaogang.com';
		}
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
		location = /favicon.ico {
			root		/root/nginx/html/old;
		}
		## 下面两项有待修改
		location /2018/06/11/SQL-Server安装教程 {
			rewrite ^(.*)$	https://wiki.wangshaogang.com/1577736;
		}
		location /2018/06/13/JDBC连接数据库示例 {
			rewrite ^(.*)$	https://wiki.wangshaogang.com/1577737;
		}

	}

	server {
		listen			443 ssl;
		server_name		bs.wangshaogang.com;
		rewrite ^(.*)		https://www.wangshaogang.com/wp-admin/;
	}

	server {
                listen                  443 ssl;
                server_name             git.wangshaogang.com;
                autoindex               on;
        	location / {
			proxy_set_header Accept-Encoding "";
			proxy_pass	http://localhost:13000;
			sub_filter_once off;
			sub_filter  '<a class="item" target="_blank" rel="noopener noreferrer" href="https://docs.gitea.io">帮助</a>'  '';
			sub_filter  '<footer>'  '<footer style="display: none">';
		}        
        }

	## 待删除
	server {
		listen			443 ssl;
		server_name		old.wangshaogang.com;
		root			/root/nginx/html/old;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}
	
	server {
		listen			443 ssl;
		server_name		vpn.wangshaogang.com;
		location = / {
			proxy_pass	http://api.yuntiss.pro/v2.php?port=10170&password=********;
		}		
	}

	server {
		listen			443 ssl;
		server_name		wiki.wangshaogang.com;
		location / {
			proxy_set_header Accept-Encoding "";
			proxy_pass	http://kancloud-wiki.wangshaogang.com/;
			sub_filter_once	off;
			sub_filter  '</body>'  '<link rel="stylesheet" type="text/css" href="mycss.css"><script src="myjs.js"></script></body>';
		}
		location =/favicon.ico {
			root		/root/nginx/html/kancloud/wiki;
		}
		location =/myjs.js {
			root		/root/nginx/html/kancloud/wiki;
		}
		location =/mycss.css {
			root		/root/nginx/html/kancloud;
		}
	}

	server {
		listen			443 ssl;
		server_name		iclass-api.wangshaogang.com;
		location / {
			proxy_set_header Accept-Encoding "";
			proxy_pass	http://kancloud-iclass-api.wangshaogang.com/;
			sub_filter_once	off;
			sub_filter  '</body>'  '<link rel="stylesheet" type="text/css" href="mycss.css"><script src="myjs.js"></script></body>';
		}
		location =/favicon.ico {
			root		/root/nginx/html/kancloud/wiki;
		}
		location =/mycss.css {
			root		/root/nginx/html/kancloud;
		}
	}

	server {
		listen			443 ssl;
		server_name		404.wangshaogang.com;
		root			/root/nginx/html/404;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}

	server {
		listen			443 ssl;
		server_name		cloud.wangshaogang.com;
		location / {
			rewrite ^(.*)$	http://wangshaogang.com:11080;
		}
	}
	
	## 即将删除 
	server {
		listen			443 ssl;
		server_name		blog.wangshaogang.com;
		root			/root/nginx/html/blog;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}
	
	server {
		listen			443 ssl;
		server_name		download.wangshaogang.com;
		root			/root/nginx/html/download;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}
	
	server {
		listen			443 ssl;
		server_name		footpoint.wangshaogang.com;
		root			/root/nginx/html/footpoint;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}

	server {
		listen			443 ssl;
		server_name		iclass-rp.wangshaogang.com;
		root			/root/nginx/html/iclass-rp;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
	}
	
	server {
		listen			443 ssl;
		server_name		iclass.wangshaogang.com;
		root			/root/nginx/html/iclass;
		error_page 403 404 500 502 503 504	/404;
		location = /404 {
			proxy_pass	https://404.wangshaogang.com/;
		}
		location /api/ {
			proxy_pass 	http://localhost:8083;
		}
	}

	server {
		listen			443 ssl;
		server_name		jdsearch.wangshaogang.com;
		location / {
			proxy_pass	http://localhost:8081;
		}
	}

	server {
		listen			443 ssl;
		server_name		text.wangshaogang.com;
		location / {
			proxy_pass	http://localhost:8082;
		}
	}

	server {
		listen			443 ssl;
		server_name		igeekshop.wangshaogang.com;
		location / {
			proxy_pass	http://localhost:8084;
		}
	}

	server {
		listen			443 ssl;
		server_name		diary.wangshaogang.com;
		location / {
			proxy_pass	http://localhost:8085;
		}
	}

	server {
		listen			443 ssl;
		server_name		picbed.wangshaogang.com;
		location / {
			proxy_pass	http://localhost:8086;
		}
	}

}
```

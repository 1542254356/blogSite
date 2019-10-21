# scp -r public/. root@47.107.131.239:/root/apache-tomcat-8.5.37/webapps/ROOT
hexo g
cd public 
tar cfv - ./* | ssh root@47.107.131.239 'cd /root/apache-tomcat-8.5.37/webapps/ROOT; tar xfv -'

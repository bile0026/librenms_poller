$MYSQL_PASS=$1
$POLLER_IP=$2

mysql -u root

GRANT ALL PRIVILEGES ON librenms.* TO 'librenms'@'$POLLER_IP' IDENTIFIED BY '$MYSQL_PASS' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
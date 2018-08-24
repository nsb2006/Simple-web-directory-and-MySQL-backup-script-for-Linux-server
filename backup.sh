#!/bin/bash

#Function: Backup website and mysql database
#Author: Jason

######~Set wwwroot and backup directory ~######
Httpdocs_path='/home/wwwroot'
Backup_tmp='/home/backup/tmp'
Backup_path='/home/backup'
Server_name='us1'

######~Set MySQL UserName, password, bin directory and database names ~######
MYSQL_UserName='root'
MYSQL_PassWord='YOUR_MYSQL_ROOT_PASS_HERE'
MYSQL_path='/usr/local/mysql/bin'

#Values Setting END!


OldHttpdocsBackup=$Server_name-httpdocs-$(date -d -21day +"%Y%m%d").tar.gz
OldDBBackup=$Server_name-db-$(date -d -21day +"%Y%m%d").tar.gz

tar -cvzPf $Backup_path/$Server_name-httpdocs-$(date +"%Y%m%d").tar.gz $Httpdocs_path/

$MYSQL_path/mysqldump -u$MYSQL_UserName -p$MYSQL_PassWord --all-databases >$Backup_tmp/%Server_name-db-all.sql 

tar --remove-files -cvzf $Backup_path/$Server_name-db-$(date +"%Y%m%d").tar.gz $Backup_tmp/* >/dev/null  2>& 1


rm -f $Backup_path/$OldHttpdocsBackup
rm -f $Backup_path/$OldDBBackup

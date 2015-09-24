#!/bin/bash

usage ()
{
  echo 'Usage : updateDynatraceCollector.sh -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file> -B <64/32 bit>'
  echo 'i.e.  : updateDynatraceCollector.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F <tmp/dynaTraceUpgrade.jar/ -B 64'
  exit
}

while [ "$1" != "" ]; do
    case $1 in
        -C | --current )        shift
                                dynatraceDirectoryOld=$1
                                ;;
        -N | --new )            shift
                                dynatraceDirectoryNew=$1
                                ;;
        -F | --file )           shift
                                dynatraceInstallFile=$1
                                ;;
		-B | --bit )        	shift
                                dynatraceBit=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ -z $dynatraceDirectoryOld ] || [ -z $dynatraceDirectoryNew ] || [ -z $dynatraceInstallFile ]
	then
	echo "Not all arugments have been supplied"
	echo "Please provide all parameters [-C CurrentDynatraceDirectory] [-N NewDynatraceDirectory] [-F Filename]"
	exit
fi

#New Server Install
echo Installing new Server...
mkdir $dynatraceDirectoryNew
echo -e $dynatraceBit\\n$dynatraceDirectoryNew\\nY\\nY | java -jar $dynatraceInstallFile

#Stop old dynaTrace service
echo Stopping Dynatrace...
$dynatraceDirectoryOld/init.d/dynaTraceCollector stop  

#Removing old Startup scripts
echo Removing old Startup scripts...
cd /etc/init.d/
osVersion=`lsb_release -a | grep 'Distributor ID' -m 1`
if [[ $osVersion == *Ubuntu* ]]; then
	$dynatraceDirectoryOld/init.d/dynaTraceCollector stop
else
	chkconfig --del dynaTraceCollector
fi
rm dynaTraceCollector

#Migration
echo Migrating Files...
dynatraceDirectory=`find / -type f -iname "dtmigration.jar" -printf "%h\n" | sort -u | grep "" -m 1`
cd $dynatraceDirectory
echo java -jar dtmigration.jar -migration -sourceDTHome $dynatraceDirectoryOld -targetDTHome $dynatraceDirectoryNew
java -jar dtmigration.jar -migration -sourceDTHome $dynatraceDirectoryOld -targetDTHome $dynatraceDirectoryNew -silent

#Automatic start configuration
echo Adding Startup scripts...
cp $dynatraceDirectoryNew/init.d/dynaTraceCollector /etc/init.d/
cd /etc/init.d/
osVersion=`lsb_release -a | grep 'Distributor ID' -m 1`
if [[ $osVersion == *Ubuntu* ]]; then
	update-rc.d dynaTraceCollector defaults
else
	chkconfig --add dynaTraceCollector
fi
cd $dynatraceDirectory

#Start new dynaTrace service
#echo Starting new Dynatrace service...
#service dynaTraceCollector start
#$dynatraceDirectoryOld/init.d/dynaTraceCollector start
echo `sdiff dtserver.ini.ToBeMigrated dtserver.ini`
read -p "Press any key to continue..."


echo `sdiff dtanalysisserver.ini.ToBeMigrated dtanalysisserver.ini`
read -p "Press any key to continue..."

echo Script Complete
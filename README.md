# Dynatrace-Upgrade-Automation

These scripts are designed to automate the upgrade process of all three dynaTrace AM components: Server, Collector, and Analysis Server. 
Scripts need to run as user with rights to write to existing files and create new directories. 

Usage for Collectors and Analysis Server
updateDynatraceAnalysisServer.sh -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file> -B <64/32 bit>'
i.e.  : updateDynatraceAnalysisServer.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F /tmp/dynaTraceUpgrade.jar -B 64'

Usage for Server
updateDynatraceAnalysisServer.sh -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file>'
i.e.  : updateDynatraceAnalysisServer.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F /tmp/dynaTraceUpgrade.jar'
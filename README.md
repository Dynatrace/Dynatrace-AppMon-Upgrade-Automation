# Dynatrace-Upgrade-Automation

These scripts are designed to automate the upgrade process of all three dynaTrace AM components: Server, Collector, and Analysis Server. 
Scripts need to run as user with rights to write to existing files and create new directories. 

Usage for Analysis Server
updateDynatraceAnalysisServer -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file> -B <64/32 bit>'
i.e.  : updateDynatraceAnalysisServer.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F /tmp/dynaTraceUpgrade.jar -B 64'

Usage for Collectors
updateDynatraceCollector -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file> -M <dtmigration.jar path> -B <64/32 bit>'
i.e.  : updateDynatraceAnalysisServer.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F /tmp/dynaTraceUpgrade.jar -M /tmp/dtmigration.jar -B 64'

Usage for Server
updateDynatraceAnalysisServer -C <new Dynatrace directory> -N <new Dynatrace directory> -F <file> -M <dtmigration.jar path>'
i.e.  : updateDynatraceAnalysisServer.sh -C /opt/dynaTrace-6.1/ -N /opt/dynaTrace-6.2/ -F /tmp/dynaTraceUpgrade.jar -M /tmp/dtmigration.jar'
Linux CPU Usage Monitor
=======================

    ./cpu-usage-monitor.sh -h
    Linux CPU Usage Monitor
 
      Author: Moises P. Sena (http://moisespsena.com)
      Original Author: Paul Colby (http://colby.id.au)
 
    Usage ./cpu-usage-monitor.sh [-l [-s|-f] |-h]

    Options

      -h: Print this messsage

      -s: Print the percent number. Example: 10

      -f: Print the formated percent number. Example: CPU: 10%

      -l: Print with infinit loop

    Examples:

      ./cpu-usage-monitor.sh -s
      ./cpu-usage-monitor.sh -f
      ./cpu-usage-monitor.sh -l -s
      ./cpu-usage-monitor.sh -l -f
      ./cpu-usage-monitor.sh -h

#!/bin/bash

kill_process=$1

file_id=`date +%d%m%Y%H%M%S`
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu > high_cpu_usage_processes_${file_id}.csv
high_cpu_process_line=`cat high_cpu_usage_processes_${file_id}.csv | head -2 | tail -1`
high_cpu_process_id=`echo $high_cpu_process_line | cut -d" " -f 1`

if [ "${kill_process}" == true ]; then
  if [ ${high_cpu_process_id} -ne 1 ]; then
    echo "PROCESS KILL: high_cpu_usage_process at ${file_id}: ${high_cpu_process_id} | ${high_cpu_process_line}"
    kill -9  ${high_cpu_process_id}
  else
    echo "NOT KILLING PROCESS ID 1: high_cpu_usage_process at ${file_id}: ${high_cpu_process_id} | ${high_cpu_process_line}"
  fi
  exit 0
else
  echo "EMAIL ALERT: high_cpu_usage_process at ${file_id}: ${high_cpu_process_id} | ${high_cpu_process_line}"
  exit 0
fi

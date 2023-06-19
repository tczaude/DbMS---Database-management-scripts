#!/bin/bash

source ./config/database.conf
# source ./bash/histogram.sh


usage(){                                    # Function: Print a help message.
    echo "Usage: $0 " 1>&2
}

exit_abnormal() {                           # Function: Exit with error.
  usage
  exit 1
}

histogram(){
    source ./bash/histogram.sh
}

build_html_dashbord(){

    source ./bash/agregate_files.sh
    source ./bash/build_html_dashbord.sh
}

while getopts "hd" options; do

    case "${options}" in
    h)
        echo "Run visualise histogram"
        histogram
        echo "Finish generate histograms"
    ;;
    d)
        echo "Build dashbord"
        build_html_dashbord
        echo "Finish build dashbord"
    ;;
    :)                                          # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                             # Exit abnormally.
      ;;
    *)                                          # If unknown (any other) option:
      exit_abnormal                             # Exit abnormally.
      ;;
  esac
done
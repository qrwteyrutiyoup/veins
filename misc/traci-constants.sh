#!/usr/bin/env bash

# Author: Sergio Correia <sergio@correia.cc>

script="${0}"
infile="${1}"

if [[ -z "${infile}" ]] || [[ ! -e "${infile}" ]]; then
  echo  "${script}: file not specified or non-existant. Usage: ${script} <SUMO_HOME/tools/traci/constants.py>"
  exit 1
else
  if [[ $(grep -n "# VERSION" "${infile}" | cut -d ':' -f 1 | wc -l) -eq 1 ]]; then
    start_constants=$(grep -n "# VERSION" "${infile}" | cut -d ':' -f 1)
    tail -n +$(($start_constants-1)) "${infile}" | sed -e 's/#/\/\//g' | sed -e '/^\/\//! s/^\([^\s\\]\)/\#define \1/g' | tr -d '=' | sed -e 's/  / /g'
  else
    echo "${script}: the file '${infile}' does not seem to be a TraCI constants file. Please check and try again."
    exit 1
  fi
fi

# vim:set ts=2 sw=2 et:

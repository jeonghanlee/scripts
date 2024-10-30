#!/usr/bin/env bash
#
#  Copyright (c) 2023    Jeong Han Lee
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : 
# version : 0.0.1

declare -g SC_SCRIPT;
#declare -g SC_SCRIPTNAME;
#declare -g SC_TOP;
#declare -g LOGDATE;

SC_SCRIPT="$(realpath "$0")";
#SC_SCRIPTNAME=${0##*/};
#SC_TOP="${SC_SCRIPT%/*}"
#LOGDATE="$(date +%y%m%d%H%M)"

function pushd { builtin pushd "$@" > /dev/null || exit; }
function popd  { builtin popd  > /dev/null || exit; }


function usage
{
    {
	echo "";
	echo "Usage : $0 input_file output_file_name "
	echo "";
	echo " bash $0 scan.pdf AL-1635-7629-TIP"
	echo ""
	
    } 1>&2;
    exit 1; 
}


function extraction
{
    local input="$1"; shift;
    local first_page="$1";shift;
    local last_page="$1";shift;
    local pre_name="$1";shift;
    local name="$1"; shift;
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${first_page} -dLastPage=${last_page} \
       -sOutputFile=${pre_name}_${name}.pdf \
       ${input}  

}

declare -a snlist;
declare -a reversed_snlist;

# snlist is hard-code number ranges
# It will use as a prefix of the output file
#
#snlist+=(766 {770..818})
snlist+=({1423..1440})
reversed_snlist=($(printf "%s\n" "${snlist[@]}" | tac))
input_pdf="$1"; shift;
output_name="$1"; shift;


if [ -z ${input_pdf}   ]; then usage; fi
if [ -z ${output_name} ]; then usage; fi

first=1;
page_offset=2;
#for prefix in "${snlist[@]}"; do
for prefix in "${reversed_snlist[@]}"; do
    #echo $prefix
    last=$((first+1));
    extraction "$input_pdf" "$first" "$last" "$prefix" "$output_name"
    first=$((first+$page_offset))
done



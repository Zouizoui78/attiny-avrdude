#!/bin/bash

HFUSE=$1
LFUSE=$2

if [[ $HFUSE != 0b* ]] || [[ $LFUSE != 0b* ]]; then
    echo "Invalid fuses format, must be 0bxxxxxxxx"
    exit 1
fi

echo "HFUSE = $HFUSE ($(printf '0x%x\n' $HFUSE))"
echo "   RSTDISBL $(cut -c 3-3 <<< $HFUSE)"
echo "       DWEN $(cut -c 4-4 <<< $HFUSE)"
echo "      SPIEN $(cut -c 5-5 <<< $HFUSE)"
echo "      WDTON $(cut -c 6-6 <<< $HFUSE)"
echo "     EESAVE $(cut -c 7-7 <<< $HFUSE)"
echo "  BODLEVEL2 $(cut -c 8-8 <<< $HFUSE)"
echo "  BODLEVEL1 $(cut -c 9-9 <<< $HFUSE)"
echo "  BODLEVEL0 $(cut -c 10-10 <<< $HFUSE)"

echo ""
echo "LFUSE = $LFUSE ($(printf '0x%x\n' $LFUSE))"
echo "     CKDIV8 $(cut -c 3-3 <<< $LFUSE)"
echo "      CKOUT $(cut -c 4-4 <<< $LFUSE)"
echo "       SUT1 $(cut -c 5-5 <<< $LFUSE)"
echo "       SUT0 $(cut -c 6-6 <<< $LFUSE)"
echo "     CKSEL3 $(cut -c 7-7 <<< $LFUSE)"
echo "     CKSEL2 $(cut -c 8-8 <<< $LFUSE)"
echo "     CKSEL1 $(cut -c 9-9 <<< $LFUSE)"
echo "     CKSEL0 $(cut -c 10-10 <<< $LFUSE)"

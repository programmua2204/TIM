#!/bin/bash
#************************************************************************
#* Program History:                                                     *
#*                                                                      *
#* Client Name  : TDEM                                                  *
#* System       : GWRDS : Getsudo Worksheet Rundown System              *
#* Module       : Calendar                                              *
#* Program ID   : BBW02130ExcelToStage.sh                               *
#* Program Name : Convert Excel to staging and target table             *
#* Description  : Convert Excel to staging and target table             *
#*                                                                      *
#* Environment  : Sun Solaris ver 10 / Oracle 11g                       *
#* Language     : Shell Scripting Language                              *
#* Author       : Thanawut T .                                          *
#* Version      : 1.0                                                   *
#* Creation Date: August 30, 2017                                       *
#*                                                                      *
#* Call Interface :                                                     *
#*                                                                      *
#* Input Parameters :                                                   *
#*    1. Version                                                		*
#*    2. Upload Type                                                    *
#*    3. Getsudo Month                                                  *
#*    4. Timing                                                         *
#*    5. Vehicle Plant                                                  *
#*    6. Vehicle Model                                                  *
#*    7. Unit Plant                                                     *
#*    8. Unit Type                                                      *
#*    9. Unit Model                                                     *
#*    10. File name                                                     *
#*    11. User ID                                                       *
#*    12. Apl Id                                                        *
#* Update History  Refix Date  Person in Charge      Description        *
#*                 2017/08/30  Thanawut              Creation           *
#* Copyright(C) 2010-TOYOTA Motor Asia Pacific. All Rights Reserved.    *
#************************************************************************
# ==================================================================
## Common Environment Setting & Function Load
# ==================================================================

#if [ ! "${ORACLE_HOME}" ];then
#    source $HOME/infra.env
#fi
if [ ! "${DB_SID}" ];then
    source $HOME/std.env
#   source $HOME/apl.env
fi

# =====================================================================
CMD=`basename $0`
CNAME=`echo $CMD | cut -d. -f1`
umask 000

#----------------------------------------------------------------------
# Error Logging File
TIMESTAMP=`date "+%Y%m%d%H%M%S"`
ERRLOGFIL=${APP_LOG_DIR}/${CNAME}${TIMESTAMP}.log

YMDHMS=`date "+%Y/%m/%d %H:%M:%S"`
echo "${YMDHMS} :${CMD} : Starting program " | tee -a ${ERRLOGFIL}

# ==================================================================
if [ $# -lt 12 ] ; then
	echo "Usage : $0 PARAM1 PARAM2 PARAM3 ... PARAM12"
	echo "Where : " 
	echo "  PARAM1 = Version"
	echo "  PARAM2 = Upload Type"
	echo "  PARAM3 = Getsudo Month"
	echo "  PARAM4 = Timing"
	echo "  PARAM5 = Vehicle Plant"
	echo "  PARAM6 = Vehicle Model"
	echo "  PARAM7 = Unit Plant"
	echo "  PARAM8 = Unit Type"
	echo "  PARAM9 = Unit Model"
	echo "  PARAM10 = File name"
	echo "  PARAM11 = User ID"
	echo "  PARAM12 = Apl Id"
	exit ${EXIT_ERROR}
else
   PARAM1=${1}
   PARAM2=${2}
   PARAM3=${3}
   PARAM4=${4}
   PARAM5=${5}
   PARAM6=${6}
   PARAM7=${7}
   PARAM8=${8}
   PARAM9=${9}
   PARAM10=${10}
   PARAM11=${11}
   PARAM12=${12}
fi

CLASS_NAME=th.co.toyota.bw0.batch.main.CBW02130ExcelToStage

echo "$YMDHMS : $CMD : Convert Excel to staging and target table begin"
echo "PARAM1 : ${PARAM1}"
echo "PARAM2 : ${PARAM2}"
echo "PARAM3 : ${PARAM3}"
echo "PARAM4 : ${PARAM4}"
echo "PARAM5 : ${PARAM5}"
echo "PARAM6 : ${PARAM6}"
echo "PARAM7 : ${PARAM7}"
echo "PARAM8 : ${PARAM8}"
echo "PARAM9 : ${PARAM9}"
echo "PARAM10 : ${PARAM10}"
echo "PARAM11 : ${PARAM11}"
echo "PARAM12 : ${PARAM12}"

DEBUG_OPTION=" "

java -Xmx1024m $DEBUG_OPTION -cp ${CLASSPATH} ${CLASS_NAME} ${PARAM1} ${PARAM2} ${PARAM3} ${PARAM4} ${PARAM5} ${PARAM6} ${PARAM7} ${PARAM8} ${PARAM9} ${PARAM10}  ${PARAM11}  ${PARAM12}
status=$?                            

#-------------------------------------------------------------------------
# ========================================================================
## Write Log File
# ========================================================================
if [ $status -eq 0 ] ; then
  echo "${YMDHMS} :${CMD} : CBW02130ExcelToStage SUCCESS "
  rm -f ${ERRLOGFIL}
  echo "${ERRLOGFIL} removed .."
  exit ${status}
elif [ $status -eq 2 ] ; then
  echo "${YMDHMS} :${CMD} : CBW02130ExcelToStage WARNING : Status= ${status}" | tee -a ${ERRLOGFIL}
  exit ${EXIT_WARNING}
else       
  echo "${YMDHMS} :${CMD} : CBW02130ExcelToStage ERROR : Status= ${status}" | tee -a ${ERRLOGFIL}
  exit ${EXIT_ERROR}       
fi           

# ========================================================================

echo "$YMDHMS : $CMD : Convert Excel to staging and target table Ended "
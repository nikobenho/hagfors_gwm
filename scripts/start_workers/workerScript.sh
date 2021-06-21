#!/bin/sh
# document this script to stdout (assumes redirection from caller)
cat $0

MODEL_NAME="hagfors_ss_template_100reals"

##### IMPORTANT ! ! ! #####
## CHANGE THIS IP ADRESS ##
MODEL_MASTER="10.18.0.223"

# receive my worker number
export WRK_NB=$1

# create worker-private subdirectory in $SNIC_TMP
export WRK_DIR=$SNIC_TMP/WRK_${WRK_NB}
mkdir $WRK_DIR

cd $SNIC_TMP/$MODEL_NAME

cp -pr . $WRK_DIR

# change to the execution directory
cd $WRK_DIR

sleep 1

./pestpp-ies hagfors.pst /H $MODEL_MASTER:4004

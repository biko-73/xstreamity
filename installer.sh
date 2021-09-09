#!/bin/sh

# ==============================================
# SCRIPT : DOWNLOAD AND INSTALL xstreamity #
# =====================================================================================================================
# Command: wget https://raw.githubusercontent.com/biko-73/xstreamity/main/installer.sh -O - | /bin/sh #
# =====================================================================================================================

########################################################################################################################
# Plugin	... Enter Manually
########################################################################################################################

PACKAGE_DIR='xstreamity/main'
MY_IPK="enigma2-plugin-extensions-xstreamity_3.16_all.ipk"
MY_DEB="eenigma2-plugin-extensions-xstreamity_3.16_all.deb"


########################################################################################################################
# Auto ... Do not change
########################################################################################################################

# Decide : which package ?
MY_MAIN_URL="https://raw.githubusercontent.com/biko-73/"
if which dpkg > /dev/null 2>&1; then
	MY_FILE=$MY_DEB
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_DEB
else
	MY_FILE=$MY_IPK
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_IPK
fi
MY_TMP_FILE="/tmp/"$MY_FILE

echo ''
echo '************************************************************'
echo '**                         STARTED                        **'
echo '************************************************************'
echo "**                 Uploaded by: Biko_73                   **"
echo "**  https://www.tunisia-sat.com/forums/threads/3898738/   **"
echo "************************************************************"
echo ''

# Remove previous file (if any)
rm -f $MY_TMP_FILE > /dev/null 2>&1

# Download package file
MY_SEP='============================================================='
echo $MY_SEP
echo 'Downloading '$MY_FILE' ...'
echo $MY_SEP
echo ''
wget -T 2 $MY_URL -P "/tmp/"

# Check download
if [ -f $MY_TMP_FILE ]; then
	# Install
	echo ''
	echo $MY_SEP
	echo 'Installation started'
	echo $MY_SEP
	echo ''
	if which dpkg > /dev/null 2>&1; then
		apt-get install --reinstall $MY_TMP_FILE -y
	else
		opkg install --force-reinstall $MY_TMP_FILE
	fi
	MY_RESULT=$?

	# Result
	echo ''
	echo ''
	if [ $MY_RESULT -eq 0 ]; then
		echo "   >>>>   SUCCESSFULLY INSTALLED   <<<<"
		echo ''
		echo "   >>>>         RESTARING         <<<<"
		if which systemctl > /dev/null 2>&1; then
			sleep 2; systemctl restart enigma2
		else
			init 4; sleep 4; init 3;
		fi
	else
		echo "   >>>>   INSTALLATION FAILED !   <<<<"
	fi;
	echo ''
	echo '**************************************************'
	echo '**                   FINISHED                   **'
	echo '**************************************************'
	echo ''
	exit 0
else
	echo ''
	echo "Download failed !"
	exit 1
fi

# ------------------------------------------------------------------------------------------------------------

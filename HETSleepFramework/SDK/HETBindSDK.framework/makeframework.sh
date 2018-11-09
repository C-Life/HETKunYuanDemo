set -e
set +u
# Avoid recursively calling this script.
if [[ $SF_MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export SF_MASTER_SCRIPT_RUNNING=1


# Constants
SF_TARGET_NAME=${PROJECT_NAME}
UNIVERSAL_OUTPUTFOLDER=`pwd`/${CONFIGURATION}-universal

# Take build target
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
then
SF_SDK_PLATFORM=${BASH_REMATCH[1]}
else
echo "Could not find platform name from SDK_NAME: $SDK_NAME"
exit 1
fi



if [[ "$SF_SDK_PLATFORM" = "iphoneos" ]]
then
echo "Please choose iPhone simulator as the build target."
exit 1
fi

IPHONE_DEVICE_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos
IPHONE_SIM_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator

echo "kkkkk"
echo `pwd`
# Build the other (non-simulator) platform
echo -e "${PROJECT_NAME}"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIM_BUILD_DIR}/x86_64" SYMROOT="${SYMROOT}" ARCHS='x86_64' VALID_ARCHS='x86_64' clean $ACTION


xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/arm64" SYMROOT="${SYMROOT}" ARCHS='arm64' VALID_ARCHS='arm64' clean $ACTION
echo "CCCC"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7" SYMROOT="${SYMROOT}" ARCHS='armv7' VALID_ARCHS='armv7' clean $ACTION

echo "AAAAA"
# Copy the framework structure to the universal folder (clean it first)

if [ ! -d "${UNIVERSAL_OUTPUTFOLDER}" ];then
	mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"
fi

if [ -d "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework" ]; then
	rm -rf "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework"
fi

cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework"
echo "BBBB"
# Smash them together to combine all architectures
lipo -create  "${BUILD_DIR}/${CONFIGURATION}-iphoneos/arm64/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/armv7/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/x86_64/${TARGET_NAME}.framework/${TARGET_NAME}" -output "${UNIVERSAL_OUTPUTFOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}"

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

BUNDLE_OUTPUTPATH=`pwd`/${TARGET_NAME}.bundle
if [ -d "${BUNDLE_OUTPUTPATH}" ]; then
	rm -rf "${BUNDLE_OUTPUTPATH}"
fi

mkdir "${BUNDLE_OUTPUTPATH}"

# Take build target
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
then
SF_SDK_PLATFORM=${BASH_REMATCH[1]}
else
echo "Could not find platform name from SDK_NAME: $SDK_NAME"
exit 1
fi

SOURCE_PATH="${BUILD_DIR}/${CONFIGURATION}-${SF_SDK_PLATFORM}/${TARGET_NAME}.framework"

echo -e "SOURCE_PATH=${SOURCE_PATH}"

find "${SOURCE_PATH}" -iname '*.nib' -print0 | while read -d $'\0' nib
do
	cp "${nib}"  "${BUNDLE_OUTPUTPATH}"
done

find "${SOURCE_PATH}" -iname '*.storyboardc' -print0 | while read -d $'\0' storyboardc
do
	cp -r "${storyboardc}"  "${BUNDLE_OUTPUTPATH}"
done

find "${SOURCE_PATH}" -iname '*.car' -print0 | while read -d $'\0' car
do
	cp "${car}"  "${BUNDLE_OUTPUTPATH}"
done

find "${SOURCE_PATH}" -iname 'Info.plist' -print0 | while read -d $'\0' plist
do
	cp "${plist}"  "${BUNDLE_OUTPUTPATH}"
done


checkXcodeProj(){
    xcodeproj=`gem list | grep "xcodeproj"`
    if test -z "$xcodeproj"; then
        echo -e "安装xcodproj"
        gem install xcodeproj
    fi
}

checkXcodeProj
echo -e "bundlName = ${TARGET_NAME}.bundle"
echo -e  ${PROJECT_NAME}




# if [[ "$SF_SDK_PLATFORM" = "iphoneos" ]]
# then
# echo "Please choose iPhone simulator as the build target."
# exit 1
# fi

# IPHONE_DEVICE_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos
# IPHONE_SIM_BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator

# echo "kkkkk"
# echo `pwd`
# # Build the other (non-simulator) platform
# xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIM_BUILD_DIR}/x86_64" SYMROOT="${SYMROOT}" ARCHS='x86_64' VALID_ARCHS='x86_64' clean $ACTION


# xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_SIM_BUILD_DIR}/i386" SYMROOT="${SYMROOT}" ARCHS='i386' VALID_ARCHS='i386' clean $ACTION

# xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/arm64" SYMROOT="${SYMROOT}" ARCHS='arm64' VALID_ARCHS='arm64' clean $ACTION
# echo "CCCC"
# xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}/armv7" SYMROOT="${SYMROOT}" ARCHS='armv7' VALID_ARCHS='armv7' clean $ACTION

# echo "AAAAA"
# # Copy the framework structure to the universal folder (clean it first)
# rm -rf "${UNIVERSAL_OUTPUTFOLDER}"
# mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"
# cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework"
# echo "BBBB"
# # Smash them together to combine all architectures
# lipo -create  "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/i386/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/arm64/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/armv7/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/x86_64/${PROJECT_NAME}.framework/${PROJECT_NAME}" -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}"

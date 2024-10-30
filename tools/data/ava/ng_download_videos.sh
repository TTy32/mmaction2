
AVA_FILE_NAMES="../../../data/ava/annotations/ava_file_names.txt"
OUTPUT_DIR="../../../data/ava/videos"
mkdir -p ${OUTPUT_DIR}
awk '{print "https://s3.amazonaws.com/ava-dataset/trainval/"$0}' ${AVA_FILE_NAMES} | parallel -j 10 wget -c -q {} -P ${OUTPUT_DIR}
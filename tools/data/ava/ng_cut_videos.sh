cd ../../../data/ava/

INPUT_DIR=$(realpath "./videos")
OUTPUT_DIR=$(realpath "./videos_15min")

mkdir -p "$OUTPUT_DIR"

process_webm() {
    input_file="$1"
    output_file="$OUTPUT_DIR/$(basename "$input_file")"
    echo "Processing $input_file (webm) to $output_file"
    #ffmpeg -ss 900 -t 901 -i "${input_file}" -r 30 -strict experimental "${output_file}"
    #ffmpeg -ss 900 -t 901 -i "${input_file}" -r 30 -c:v libvpx-vp9 -cpu-used 4 -b:v 1M -c:a opus -strict -2 "${output_file}"
    ffmpeg -ss 900 -t 901 -i "${input_file}" -r 30 -vsync cfr -c:v libvpx-vp9  -g 60 -force_key_frames "expr:gte(t,n_forced*2)" -cpu-used 4 -b:v 1M -c:a opus -strict -2 "${output_file}"
}

process_non_webm() {
    input_file="$1"
    extension="${input_file##*.}"
    output_file="$OUTPUT_DIR/$(basename "$input_file")"
    echo "Processing $input_file (non-webm) to $output_file"
    # ffmpeg -hwaccel cuda -ss 900 -t 901 -i "${input_file}" -r 30 -strict experimental "${output_file}"
    ffmpeg -hwaccel cuda -ss 900 -t 901 -i "${input_file}" -r 30 -vsync cfr -c:v libx264  -g 60 -force_key_frames "expr:gte(t,n_forced*2)" -strict experimental "${output_file}"
}

# Exports so parallel can see them
export -f process_webm
export -f process_non_webm
export OUTPUT_DIR

find "$INPUT_DIR" -type f -name "*.webm" | parallel --line-buffer -j 4 process_webm {} &
find "$INPUT_DIR" -type f ! -name "*.webm" | parallel --line-buffer -j 2 process_non_webm {} &
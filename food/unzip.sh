#!/bin/bash

SOURCE_PATH=$1
DEST_PATH=$2


if [ ! -d "$SOURCE_PATH" ]; then
    echo "폴더 경로 $SOURCE_PATH 가 존재하지 않습니다."
    exit 1
fi

if [ ! -d "$DEST_PATH" ]; then
    echo "폴더 경로 $DEST_PATH 가 존재하지 않습니다."
    exit 1
fi

for zip_file in "$SOURCE_PATH"/*.zip; do
    if [ ! -e "$zip_file" ]; then
        echo "압축 파일이 없습니다."
        continue
    fi

    echo "압축 해제 중: $zip_file"
    unzip_folder="${zip_file%.zip}" 
    unzip -o "$zip_file" -d "$DEST_PATH" && echo "$zip_file 압축 해제 완료" || echo "$zip_file 압축 해제 실패"
done

rm -r "$SOURCE_PATH"

for zip_file in "$DEST_PATH"/*.zip; do
    if [ ! -e "$zip_file" ]; then
        echo "압축 파일이 없습니다."
        continue
    fi

    echo "압축 해제 중: $zip_file"
    unzip_folder="${zip_file%.zip}" 
    unzip -o "$zip_file" -d "$DEST_PATH" && echo "$zip_file 압축 해제 완료" || echo "$zip_file 압축 해제 실패"
    rm "$zip_file"
done


for folder in "$DEST_PATH"/*/; do
    if [ -d "$folder/json" ]; then
        echo "$folder/json 폴더 삭제"
        rm -rf "$folder/json"
    fi

    if [ -d "$folder/png" ]; then
        echo "$folder/png 폴더 내 파일 상위 폴더로 이동"
        mv "$folder/png"/* "$folder/" 2>/dev/null  
        rmdir "$folder/png" 2>/dev/null          
    fi

    if [ -e "$folder/._.DS_Store" ]; then
        rm "$folder/._.DS_Store" 2>/dev/null          
    fi

    if [ -e "$folder/._.DS_Store" ]; then
        rm "$folder/._.DS_Store" 2>/dev/null          
    fi
done

echo "모든 작업 완료"

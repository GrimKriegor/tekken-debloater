#!/bin/bash

EMPTYFILE_PATH="$(dirname -- $0)/empty-file.usm"
STEAMAPPS_DIR="${HOME}/.steam/steam/steamapps"
TEKKEN_DIR="${STEAMAPPS_DIR}/common/TEKKEN 8"
MOVIES_DIR="${TEKKEN_DIR}/Polaris/Content/Movies/usm"

MOVIES_SUBDIR=(
  "CharEpisode"
  "Gallery"
  "Lobby"
  "StartUp"
  "Story"
  "StoryChapterSelect"
  "StoryDLC"
  "StoryTournament"
  "TAM"
  "YellowBook"
)

while getopts p param; do
  case "${param}" in
    p) pack_dirs_for_release="TRUE" ;;
  esac
done

for subdir in ${MOVIES_SUBDIR[@]}; do
  echo "Replacing movies in ${subdir}"
  find "${MOVIES_DIR}/${subdir}" -type f -name "*.usm" \
    -exec cp "${EMPTYFILE_PATH}" {} \;
done

if [ "${pack_dirs_for_release}" ]; then
  echo "Packing altered directories for release"
  pushd "${MOVIES_DIR}"
  zip -q -r "$(dirs -l +1)/tekken8-debloater_$(date +'%Y%m%d').zip" ${MOVIES_SUBDIR[@]}
  popd
fi

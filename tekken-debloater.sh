#!/bin/bash

emptyfile_path="$(dirname -- $0)/empty-file.usm"
steamapps_dir="${HOME}/.steam/steam/steamapps"
tekken_version="8"

while getopts ':v:p' param; do
  case "${param}" in
    s) steamapps_dir="$OPTARG" ;;
    v) tekken_version="$OPTARG" ;;
    p) create_release_archive="TRUE" ;;
  esac
done

tekken_dir="${steamapps_dir}/common/TEKKEN ${tekken_version}"
case "${tekken_version}" in
  7)
    movies_dir="${tekken_dir}/TekkenGame/Content/Movies"
    movies_subdir=(
      "Gallery"
      "Story"
    )
  ;;
  8)
    movies_dir="${tekken_dir}/Polaris/Content/Movies/usm"
    movies_subdir=(
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
  ;;
  *)
    echo "TEKKEN ${tekken_version} is not supported."
    exit 1;
  ;;
esac

echo "Working with TEKKEN ${tekken_version} installed in \"${tekken_dir}\""

for subdir in ${movies_subdir[@]}; do
  echo "Replacing movies in ${subdir}"
  find "${movies_dir}/${subdir}" -type f -name "*.usm" \
    -exec cp "${emptyfile_path}" {} \;
done

if [ "${create_release_archive}" ]; then
  echo "Packing altered directories for release"
  pushd "${movies_dir}" > /dev/null
  zip -q -r "$(dirs -l +1)/tekken${tekken_version}-debloater_$(date +'%Y%m%d').zip" ${movies_subdir[@]}
  popd > /dev/null
fi

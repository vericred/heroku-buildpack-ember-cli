clean_npm() {
  status "Cleaning up node-gyp and npm artifacts"
  rm -rf "$build_dir/.node-gyp"
  rm -rf "$build_dir/.npm"
}

clean_node_cache() {
  status "Cleaning node cache"
  rm -rf "$cache_dir/node_modules" # (for apps still on the older caching strategy)
  rm -rf "$cache_dir/node"

  rm -rf "$build_dir/node_modules"
  rm -rf "$build_dir/node"

  npm cache clean
}

create_cache() {
  status "Caching node_modules directory for future builds"
  cp -r $build_dir/node_modules $cache_dir/node
}

write_user_cache() {
  local directories=($(cache_directories))
  if [ "$directories" != -1 ]; then
    info "Storing directories:"
    for directory in "${directories[@]}"
    do
      info "- $directory"
      cp -r $build_dir/$directory $cache_dir/node/
    done
  fi
}

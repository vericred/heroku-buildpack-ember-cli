clean_npm() {
  status "Cleaning up node-gyp and npm artifacts"
  rm -rf "$build_dir/.node-gyp"
  rm -rf "$build_dir/.npm"
}

clean_node_cache() {
  status "Cleaning node cache"
  # (for apps still on the older caching strategy)
  rm -rf "$cache_dir/node_modules"
  rm -rf "$cache_dir/node"

  npm cache clean
}

clean_bower_cache() {
  status "Cleaning bower cache"
  rm -rf "$cache_dir/bower_components"
}

create_bower_cache() {
  status "Caching bower_components directory for future builds"
  clean_bower_cache
  cp -r $build_dir/bower_components $cache_dir/bower_components
}

create_node_cache() {
  status "Caching node_modules directory for future builds"
  clean_node_cache
  cp -r $build_dir/node_modules $cache_dir/node
}

restore_node_cache() {
  # Restore bower_components from cache if it exists
  rm -rf $build_dir/node_modules
  if test -d $cache_dir/node_modules; then
    status "Restoring node_modules directory from cache"
    cp -r $cache_dir/node $build_dir/node_modules
  fi
}

restore_bower_cache() {
  # Restore bower_components from cache if it exists
  rm -rf $build_dir/bower_components
  if test -d $cache_dir/bower_components; then
    status "Restoring bower_components directory from cache"
    cp -r $cache_dir/bower_components $build_dir/
  fi
}
require 'shrine/storage/file_system'

Shrine.storages = {
  store: Shrine::Storage::FileSystem.new(ENV.fetch('STORAGE_DIR', 'tmp/storage')),
  cache: Shrine::Storage::FileSystem.new(ENV.fetch('CACHE_STORAGE_DIR', 'tmp/storage/cache')),
}

Shrine.plugin :sequel
Shrine.plugin :upload_options, cache: { move: true }, store: { move: true }
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data

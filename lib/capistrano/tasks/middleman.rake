namespace :middleman do
  middleman_options = Array(fetch(:middleman_options, %w(--verbose)))

  archive_name                = fetch :archive_name, 'archive.zip'
  build_dir                   = fetch :build_dir, 'build'
  source_dir                  = fetch :source_dir, 'source'
  keep_filesystem_permissions = fetch :keep_filesystem_permissions, false
  directory_permissions       = fetch :directory_permissions, 2775
  file_permissions            = fetch :file_permissions, 0664

  exclude_patterns  = Array(fetch(:exclude_patterns))

  tar_roles         = fetch(:tar_roles, :all)
  desc "Archive files to #{archive_name}"
  file archive_name => source_dir do |t|
    cmd = %w(middleman build)
    cmd.concat middleman_options
    sh cmd.join(' ')

    Capistrano::Middleman::Utils.zip(
      build_dir,
      t.name,
      working_directory: build_dir,
      exclude_patterns: exclude_patterns,
      keep_filesystem_permissions: keep_filesystem_permissions,
      directory_permissions: directory_permissions,
      file_permissions: file_permissions
    )
  end

  desc "Build #{archive_name} on localhost"
  task build: archive_name do
    run_locally do
      info "Archive \"#{archive_name}\" created."
    end
  end

  desc "Deploy #{archive_name} to release_path"
  task create_release: archive_name do |t|
    archive_file = t.prerequisites.first

    on release_roles tar_roles do |host|
      # Make sure the release directory exists
      info "==> release_path: #{release_path} is created on #{tar_roles} roles for host #{host} <=="
      execute :install, "-d -m #{directory_permissions}", release_path

      # Create a temporary file on the server
      tmp_file = capture('mktemp')

      # Upload the archive, extract it and finally remove the tmp_file
      upload!(archive_file, tmp_file)

      umask = capture('umask')
      debug "umask on remote system #{host} is #{umask}"

      execute :unzip, tmp_file, '-d', release_path
      execute :rm, '-f', tmp_file
    end
  end

  desc 'Cleaning up deploy'
  task :clean do |_t|
    FileUtils.rm_rf build_dir
    FileUtils.rm_rf archive_name
  end

  after 'deploy:finished', 'middleman:clean'

  task :check
  task :set_current_revision
end

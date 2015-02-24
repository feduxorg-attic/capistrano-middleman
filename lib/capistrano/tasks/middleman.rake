namespace :middleman do
  middleman_options = Array(fetch(:middleman_options, %w(--verbose)))

  archive_name      = fetch :archive_name, 'archive.tar.gz'
  build_dir         = fetch :build_dir, 'build'
  source_dir        = fetch :source_dir, 'source'
  exclude_dir       = Array(fetch(:exclude_dir))
  exclude_args      = exclude_dir.map { |dir| "--exclude '#{dir}'"}

  tar_roles         = fetch(:tar_roles, :all)

  desc "Archive files to #{archive_name}"
  file archive_name => source_dir do |t|
    cmd = %w(middleman build)
    cmd.concat middleman_options

    sh cmd.join(' ')

    files = FileList.new(File.join(build_dir, '*')).sub(%r{#{build_dir}/?}, '')

    cmd = %w(tar -cvzf)
    cmd << t.name
    cmd << "-C #{build_dir}"
    cmd.concat exclude_args
    cmd.concat files

    sh cmd.join(' ')
  end

  desc "Deploy #{archive_name} to release_path"
  task create_release: archive_name do |t|
    tarball = t.prerequisites.first

    on release_roles tar_roles do |host|
      # Make sure the release directory exists
      puts "==> release_path: #{release_path} is created on #{tar_roles} roles <=="
      execute :install, "-d -m 755", release_path

      # Create a temporary file on the server
      tmp_file = capture('mktemp')

      # Upload the archive, extract it and finally remove the tmp_file
      upload!(tarball, tmp_file)

      execute :tar, '-xzf', tmp_file, '-C', release_path
      execute :rm, '-f', tmp_file
    end
  end

  desc 'Cleaning up deploy'
  task :clean do |t|
    FileUtils.rm_rf build_dir
    FileUtils.rm_rf archive_name
  end

  after 'deploy:finished', 'middleman:clean'

  task :check
  task :set_current_revision
end

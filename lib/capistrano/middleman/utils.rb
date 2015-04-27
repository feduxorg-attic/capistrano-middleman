module Capistrano
  module Middleman
    # Utils
    module Utils
      # Create zip archive from source directory
      #
      # @param [String] source_directory
      #   The directory
      # @param [String] destination_file
      #   Name of the zip file
      # @param [String] prefix
      #   Prefix inside zip file
      # @param [String] working_directory
      #   The directory where rubyzip should change to
      # @param [Array] exclude_patterns
      #   Ignore files matching patterns
      # @param [TrueClass, FalseClass] keep_filesystem_permissions
      #   Record permissions in file system
      # @param [OctalNumber] file_permissions
      #   Permissions for files
      # @param [OctalNumber] directory_permissions
      #   Permissions for directories
      def zip(
        source_directory,
        destination_file,
        prefix: nil,
        working_directory: Dir.getwd,
        exclude_patterns: [],
        keep_filesystem_permissions: false,
        file_permissions: 0664,
        directory_permissions: 2775
      )
        list = Rake::FileList.new(File.join(source_directory, '**', '*'))
        list.exclude { |f| !File.file? f }
        exclude_patterns.each { |e| list.exclude e }

        Zip::File.open(destination_file, Zip::File::CREATE) do |z|
          list.uniq.each do |filename|
            paths = []
            paths << Pathname.new(prefix) unless prefix.nil? || prefix.empty?
            paths << Pathname.new(filename).relative_path_from(Pathname.new(working_directory))

            z.add(File.join(*paths), File.expand_path(filename))

            next if keep_filesystem_permissions

            z.file.chmod(file_permissions, File.join(*paths)) if z.file.file? File.join(*paths)
            z.file.chmod(directory_permissions, File.join(*paths)) if z.file.directory? File.join(*paths)
          end
        end
      end

      module_function :zip
    end
  end
end

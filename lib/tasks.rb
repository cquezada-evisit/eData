Dir[File.join(__dir__, 'edata_eav', 'tasks', '*.rake')].each { |ext| load ext } if defined?(Rake)

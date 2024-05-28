if defined?(Rake)
  Dir[File.join(__dir__, 'edata_eav/tasks/*.rake')].each { |file| load file }
end

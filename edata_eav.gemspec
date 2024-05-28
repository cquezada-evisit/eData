Gem::Specification.new do |spec|
  spec.name          = "edata_eav"
  spec.version       = "0.1.0"
  spec.authors       = ["Christopher Quezada"]
  spec.email         = ["cquezada@evisit.com"]

  spec.summary       = "A gem to manage EAV model in MySQL for Rails 5"
  spec.description   = "This gem provides tools to manage an Entity-Attribute-Value model in MySQL for Rails 5 applications."
  spec.homepage      = "https://github.com/cquezada-evisit/eData-PoC"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4.22"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "activerecord", ">= 5.2", "< 7.0"
  spec.add_dependency "mysql2", ">= 0.3.18"
end

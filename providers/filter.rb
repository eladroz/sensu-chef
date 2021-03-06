action :create do
  definition = {
    "filters" => {
      new_resource.name => SensuDefinitions.sanitize(new_resource.to_hash,
                             :master_keys => %w[attributes negate])
    }
  }

  filters_directory = ::File.join(node.sensu.directory, "conf.d", "filters")

  directory filters_directory do
    recursive true
    mode 0755
  end

  sensu_json_file ::File.join(filters_directory, "#{new_resource.name}.json") do
    mode 0644
    content definition
  end
end

action :delete do
  sensu_json_file ::File.join(node.sensu.directory, "conf.d", "filters", "#{new_resource.name}.json") do
    action :delete
  end
end

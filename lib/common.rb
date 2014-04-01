require 'yaml'

DWCOUNT_PATH = '.dwcountrc'
DWCOUNT_OPTS = {
  page: nil,
  rows: nil,
  cols: nil,
  history_path: nil,
}

DWFORMAT_PATH = '.dwformatrc'
DWFORMAT_OPTS = {
  replace: {
    # Ellipsis
    "\u30fb\u30fb" => "\u2026\u2026",
    # Roman numerals
    '{I}' => "\u2160",
    '{II}' => "\u2161",
    '{III}' => "\u2162",
    '{IV}' => "\u2163",
    '{V}' => "\u2164",
    '{VI}' => "\u2165",
    '{VII}' => "\u2166",
    '{VIII}' => "\u2167",
    '{IX}' => "\u2168",
    '{X}' => "\u2169",
  }
}

def save_yaml(file_path, data)
  YAML.dump(data, open(file_path, 'w'))
end

def parents_file_path(file_name)
  dir_path = Dir.pwd
  until File.exist?(File.join(dir_path, file_name))
    new_dir_path = File.dirname(dir_path)
    return nil if dir_path == new_dir_path
    dir_path = new_dir_path
  end
  File.join(dir_path, file_name)
end

def dwcount_default(opts)
  opts[:page] ||= 'dp'
  case opts[:page]
  when 'dp'
    opts[:rows] ||= 42
    opts[:cols] ||= 34
  else
    opts[:rows] ||= 20
    opts[:cols] ||= 20
  end
  opts[:history_path] ||= '.dwcount_history'
end

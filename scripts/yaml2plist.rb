#!/usr/bin/env ruby
require "yaml"
require "pp"

data = YAML.safe_load(open(ARGV[0]))

def handle_dict(key, value, depth = 0)
  puts ("  " * depth) + "<key>#{key}</key>" if key
  puts ("  " * depth) + "<dict>"
  value.each do |subkey, subvalue|
    if subvalue.class == String
      handle_string(subkey, subvalue, depth + 1)
    elsif subvalue.class == Integer
      handle_integer(subkey, subvalue, depth + 1)
    elsif subvalue.class == Hash
      handle_dict(subkey, subvalue, depth + 1)
    elsif subvalue.class == Array
      handle_array(subkey, subvalue, depth + 1)
    elsif subvalue.class == TrueClass || subvalue.class == FalseClass
      handle_bool(subkey, subvalue, depth + 1)
    else
      warn "Unknown value type for key #{subkey}: #{subvalue.class} (#{subvalue.inspect})"
      exit 1
    end
  end
  puts ("  " * depth) + "</dict>"
end

def handle_array(key, value, depth = 0)
  puts ("  " * depth) + "<key>#{key}</key>" if key
  puts ("  " * depth) + "<array>"
  value.each do |subvalue|
    handle_string(nil, subvalue, depth + 1)
  end
  puts ("  " * depth) + "</array>"
end

def handle_string(key, value, depth = 0)
  puts ("  " * depth) + "<key>#{key}</key>" if key
  puts ("  " * depth) + "<string>#{value}</string>"
end

def handle_integer(key, value, depth = 0)
  puts ("  " * depth) + "<key>#{key}</key>" if key
  puts ("  " * depth) + "<integer>#{value}</integer>"
end

def handle_bool(key, value, depth = 0)
  puts ("  " * depth) + "<key>#{key}</key>"
  if value
    puts ("  " * depth) + "<true/>"
  else
    puts ("  " * depth) + "<false/>"
  end
end

puts <<~EOF
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
EOF

data_array = data.to_a
data_array.unshift(["Label", ARGV[0].sub(/.yml$/, "")])
handle_dict(nil, data_array, 0)
# pp data.to_a

puts <<~EOF
  </plist>
EOF


lambda { |stdout,stderr,status|
  output = stdout + stderr
  error_pattern = /(\d+) errors?/
  pattern = /(\d+) specs?, (\d+) failures?/
  if error_pattern.match(output)
    :amber
  elsif match = pattern.match(output)
    match[2] == '0' ? :green : :red
  else
    :amber
  end
}

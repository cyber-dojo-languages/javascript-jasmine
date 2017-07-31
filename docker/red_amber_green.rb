
lambda { |stdout,stderr,status|
  output = stdout + stderr
  pattern = /(\d+) specs?, (\d+) failures?/
  if match = pattern.match(output)
    match[2] == '0' ? :green : :red
  else
    :amber
  end
}

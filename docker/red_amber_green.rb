
lambda { |stdout,stderr,status|
  output = stdout + stderr
  pattern = /^(\d+) spec(s?), (\d+) failure(s?)/
  if match = pattern.match(output)
    match[3] == '0' ? :green : :red
  else
    :amber
  end
}

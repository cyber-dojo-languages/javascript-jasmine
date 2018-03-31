
lambda { |stdout,stderr,status|
  output = stdout + stderr
  js_hint_pattern = /^(\d+) error(s?)/
  pattern = /^(\d+) spec(s?), (\d+) failure(s?)/
  if js_hint_pattern.match(output)
    :amber
  elsif match = pattern.match(output)
    match[3] == '0' ? :green : :red
  else
    :amber
  end
}

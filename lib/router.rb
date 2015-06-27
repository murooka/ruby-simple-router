require "router/version"

class Router

  attr_reader :routes
  attr_reader :regexp

  def initialize
    @routes = []
    @dests = {}
    @latest_id = 1
    @regexp = nil
  end

  def add(path, dest)
    @regexp = nil
    id = "_#{@latest_id}"
    @dests[id] = dest
    @routes.push({ id: id, path: path })
    @latest_id += 1
  end

  def match(path)
    @regexp ||= build_regexp

    res = self.regexp.match(path)
    return nil unless res

    capts = res.names.map { |n| [n, res[n]] }.to_h.reject { |_,v| v.nil? }
    id = capts.keys.select { |n| n.start_with? '_' }.first
    return nil unless id

    dest = @dests[id]
    captures = capts.reject { |k,_| k.start_with? '_' }

    {
      dest: dest,
      captures: captures.map { |k,v| [k.to_sym, v] }.to_h,
    }
  end

private

  def build_regexp
    rgxs = self.routes.map do |route|
      id = route[:id]
      path = route[:path]
      r = path.gsub(/:([a-zA-Z_]+)/, '(?<\1>[^/]+)')
      "(?<#{id}>^#{r}$)"
    end
    Regexp.new('' + rgxs.join('|') + '')
  end

end

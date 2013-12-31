require 'rubygems'
require 'bundler/setup'
require 'json'
require 'shellwords'
require 'logger'
LOG = Logger.new STDERR
run lambda{|env|
  req = Rack::Request.new env
  msg = JSON.parse req.body.read
  repo = msg['repository']['url']
  LOG.info "Request for: #{repo}"
  status = (
    conf = eval File.new('./config.rb').read
    conf[:repos].select{|i| i[:uri] == repo}.map{|i|
      cmd = "cd #{conf[:repos_path].shellescape}/#{/[^\/:]*\/[^\/]*$/.match(repo)[0]} && git push --quiet #{i[:push].shelljoin}"
      LOG.info "Run: #{cmd}"
      status = system cmd
      LOG.info "Exit status: #{status}"
      status
    }
  )
  LOG.info "No matching repos found" if status.empty?
  [status.empty? ? 404 : status.all? ? 200 : 500, {}, []]
}

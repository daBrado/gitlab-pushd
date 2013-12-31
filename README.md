# GitLab PushD

GitLab PushD is a Ruby + Rack implementation of a simple daemon to push git repos to elsewhere as triggered by a GitLab web hook.

## Install

To install for deployment, you can do:

    RUBY=/path/to/ruby
    $RUBY/bin/gem install bundler -i vendor/gem -n bin
    bin/bundle install --deployment --binstubs --shebang $RUBY/bin/ruby

You will also need to create a `config.rb` file for your environment.  There is an example provided.

There is also an example Upstart config to show how you can run it as a service.

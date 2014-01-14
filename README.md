# GitLab PushD

GitLab PushD is a Ruby + Rack implementation of a simple daemon to push git repos to elsewhere as triggered by a GitLab web hook.

## Install

To install for deployment, you can do:

    RUBY=/path/to/ruby
    $RUBY/bin/gem install bundler -i vendor/gem -n bin
    bin/bundle install --deployment --binstubs --shebang $RUBY/bin/ruby

You will also need to create a `config.rb` file for your environment.  There is an example provided.

There is also an example Upstart config to show how you can run it as a service.

## Usage

Run `pushd` on the host where your central git repositories live, and make a `config.rb` file as outlined in the included example.

In GitLab, then add a web hook that points to the running `pushd` application uri.

### Without GitLab

Given that GitLab just talks JSON, if you want to trigger the `pushd` daemon directly from a git hook, you can use the `update` hook, and do something like:

    #!/bin/sh
    repouri=git@git.example.org:myrepo.git
    pushd=http://git.example.org:29224
    curl --data '{"repository":{"url":"'$repouri'"}}' $pushd

The `repouri` only needs to match whatever you listed in the `config.rb` file, i.e. just some unique identifier of your choosing.

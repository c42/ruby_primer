# The Ruby Initiate

© Copyright 2011 [C42 Engineering][]. All Rights Reserved.

## Teach Ruby!

<h4>Fork this repository, make changes and use the RubyMonk SandboxL for a live preview. Send us a pull request when you are done!</h4>

The Ruby Initiate is an open collaboration initiative that uses the [RubyMonk][] platform to help teach the Ruby Programming Language.

## How to Contribute

- Fork this repository.
- Make your changes in docs/
- run `bundle install && bin/rubymonk.rb` to generate the URL to your very own RubyMonk sandbox.
- Use the generated URL to preview your work.
- Once you are happy with your changes, send us a pull request with a clear description of changes you've done.
- Like any other open-source project, your pull request will be reviewed and then merged.

## How does this work?

The [RubyMonk][] platform allows you to create and publish online e-books that contain embeddable, runnable Ruby code and tests.

RubyMonk uses standard HAML markup in combination with our very own DSL to achieve this. When you fork this repository and send us a pull request you are contributing content to The Ruby InitiateLQ, an introductory primer to the Ruby language.

The Ruby Initiate is a free, open and interactive e-book published on the RubyMonk platform.

## The Magic DSL


All the content is inside `docs/`.
The lessons are placed inside `docs/<chapter>` and are in the HAML format with some metadata interspersed. Here is a template:

    title - <Title of the chapter>
    .section :a_short_name_of_the_section, "Title of the section"
      %p
         A paragraph. You can use any valid HAML here. Be mindful of the spacing though!

      !enchant
        short_name :short_name_of_the_exercise
        exercise!
        starting_code <<-DATA
          "sample starting code. uses Ruby's multiline construct"
        DATA
        code_wrapper <<-DATA
          # you can use ERB templating here.
          # the user_code is passed as a variable to the templating engine.
          def method_that_gives_result_of_the_users_input
            <%= user_code %>
          end
        DATA
        specs <<-DATA
          it "the user should give the string xyz to pass this spec" do
            method_that_gives_result_of_the_users_input.should eq('xyz')
          end
        DATA
      !release

The `enchant` starts a block of exercise. Use `release` once you are done. Every `enchant` block mandatorily requires the following attributes:

- `exercise!` or `example!` : An exercise has specs which have to pass for the user to continue. An example can be run, but does not affect the user's progress.
- `short_name` : short_name is used in the URLs for referring to the section.
- `starting_code` : Sample code that will appear by default in the code-block.
- `code_wrapper` : Custom method that will digest user code.
- `specs` : RSpec block that tests the custom `code_wrapper` method.

An exercise needs to have:

- `starting_code`
- `code_wrapper`
- `specs`

An example needs to have:

- `starting_code`

The numbers in the `section` and `enchant` lines are the `id`s of the metadata. If you are creating a new section, don't bother about them. When modifiying existing section/enchant, please do not change the `id`.

Please take a look at the existing lessons to understand the DSL better.

### Prerequisites

- Ruby - CRuby 1.9.2 and upward are supported.
- Bundler (gem)

## Got any questions? Talk to us!

- Twitter: [@rubymonk](http://twitter.com/#!/rubymonk 'RubyMonk')
- IRC: #rubymonk @ irc.freenode.org

[RubyMonk]: http://rubymonk.com
[C42 Engineering]: http://c42.in


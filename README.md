# Ruby Primer
© Copyright 2011 [RubyMonk][], [C42 Engineering][]. All Rights Reserved.

## What is it about?

Ruby Primer is an open collaboration initiative to provide content for RubyMonk.
With this platform, RubyMonk hopes to serve top-notch, error-free and validated free-to-use content.

## Contributing

By forking this repository, it is possible to access all the content and exercises currently present on RubyMonk.
Using the sandbox environment Ruby Primer provides, modifications and additions can be seen locally.
A Github pull request can be made if you feel your contributions should appear on RubyMonk

### Prerequisites

- Ruby - CRuby 1.8.7/1.9.2 and upward are supported.
- Git > v1.6.5

### Using the sandbox environment

`bin/ruby_monk.rb` to start the sandbox server and get the unique URL that will serve live content.

### Understanding the DSL

All the content is inside `docs/`.
The lessons are placed inside `docs/<chapter>` and are in the HAML format with some metadata interspersed. Here is a template:

<code>
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
        # you can use ERB templating here. the `user_code` is passed as a variable to the templating engine.
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
</code>

The `enchant` starts a block of exercise. Use `release` once you are done. Every `enchant` block mandatorily requires the following attributes:

- `exercise!` or `example!`
An exercise has specs which have to pass for the user to continue.
An example can be run, but does not affect the user's progress.

- `short_name`
short_name is used in the URLs for referring to the section.

- `starting_code`
Sample code that will appear by default in the code-block.

- `code_wrapper`
Custom method that will digest user code.

- `specs`
RSpec block that tests the custom `code_wrapper` method.

An exercise needs to have:

- `starting_code`

- `code_wrapper`

- `specs`

An example needs to have:

- `starting_code`

The numbers in the `section` and `enchant` lines are the `id`s of the metadata. If you are creating a new section, don't bother about them. When modifiying existing section/enchant, please do not change the `id`.
Please take a look at the existing lessons to understand the DSL better.

## Got any questions? Talk to us!

- Twitter: [@rubymonk](http://twitter.com/#!/rubymonk 'RubyMonk')
- IRC: #rubymonk @ irc.freenode.org

[RubyMonk]: http://rubymonk.com
[C42 Engineering]: http://c42.in

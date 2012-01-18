# The Ruby Primer

© Copyright 2011 [C42 Engineering][]. All Rights Reserved.

## Teach Ruby!

For simple spelling and grammar changes, <strong>simply fork, edit, commit and send us a pull request!</strong>

If you want to add content and need your own private RubyMonk sandbox to test your changes, read on.

The Ruby Primer is an open collaboration initiative that uses the [RubyMonk][] platform to help teach the Ruby Programming Language.

## How to Contribute

- Fork this repository.
- run `bundle install && bin/rubymonk.rb` to generate the URL to your very own RubyMonk sandbox.
- Use the generated URL to preview the contents in the sandbox.
- Make your changes in `docs/`. The sandbox URL will get updated with your changes as you make them.
- Once you are happy with your changes, send us a pull request with a clear description of changes you've done.
- Like any other open-source project, your pull request will be reviewed and then merged.

## How does this work?

The [RubyMonk][] platform allows you to create and publish online e-books that contain embeddable, runnable Ruby code and tests.

RubyMonk uses standard Haml markup in combination with our very own DSL to achieve this. When you fork this repository and send us a pull request you are contributing content to The Ruby Primer, an introductory primer to the Ruby language.

The Ruby Primer is a free, open and interactive e-book published on the RubyMonk platform.

## The Magic DSL

All the content is inside `docs/`.
The lessons are placed inside `docs/<chapter>/<lesson_name>`.

The lessons make use of standard [Haml markup][] for content. It is interspersed with metadata that allows you to define code blocks.

Every lesson starts with a `section`. A section needs a `short_name` and a `title`. 

Here is a template:

    title - <Title of the lesson>
    .section :a_short_name_of_the_section, "Title of the section"
      %p
         A paragraph. You can use any valid Haml here. Be mindful of the spacing though!

      !enchant
      
        short_name :short_name_of_the_exercise
        
        exercise!
        
        starting_code <<-DATA
          # sample starting code.
          # uses Ruby's multiline construct.
          # code that will appear in the block by default.
        DATA
        
        code_wrapper <<-DATA
          # you can use ERB templating here.
          # the user_code is passed as a variable to the templating engine.
          def method_that_gives_result_of_the_users_input
            <%= user_code %>
          end
        DATA
        
        specs <<-DATA
          #
          it "the user should give the string xyz to pass this spec" do
            method_that_gives_result_of_the_users_input.should eq('xyz')
          end
        DATA
        
      !release

The `!enchant` starts a block of exercise. Use `!release` once you are done. Every `!enchant` block mandatorily requires the following attributes:

- `exercise!` or `example!` : An exercise has specs which have to pass for the user to continue. An example can be run, but does not affect the user's progress.
- `short_name` : short_name is used in the URLs for referring to the section.
- `starting_code` : Sample code that will appear by default in the code-block.
- `code_wrapper` : This is the block of code where you create a method to wrap the code
 written by the user. RubyMonk uses ERB templating to render it, the user's code is passed in as the variable `user_code`.
- `specs` : RSpec block that tests the method in the `code_wrapper`.

To display any specific text in the RubyMonk output window when running a particular exercise, 
add `puts` or a similar command that writes to `stdout` in either the `specs` or the `code_wrapper` block. 

An exercise needs to have:

- `starting_code`
- `code_wrapper`
- `specs`

An example needs to have:

- `starting_code`

The numbers in the `section` and `enchant` lines are the `id`s of the metadata. You can skip adding a number there if you are creating a new section. But when modifiying existing section/enchant blocks that have an `id`, please leave them as is.

Go ahead and check out the existing lessons to get a hold of the DSL better.

## Scope

The Ruby Primer is targeted at programmers who are learning Ruby for the first time. However people who are completely new to programming have also found it useful. The scope of The Ruby Primer is to cover just enough basics to help one get started with Ruby.

For trivial changes to the content, you can use the GitHub `Edit` option instead of manually forking and sending a pull request.

## Prerequisites

- Ruby - CRuby 1.9.2 and upwards are supported.
- Bundler (gem)

The Ruby Primer sandbox client has been tested on Linux and Mac OS X. We welcome help in ensuring compatibility with Windows.

## Got any questions? Talk to us!

- Twitter: [@rubymonk](http://twitter.com/#!/rubymonk 'RubyMonk')
- email: [rubymonk@c42.in](mailto:rubymonk@c42.in)
- IRC: #rubymonk @ irc.freenode.net

[RubyMonk]: http://rubymonk.com
[C42 Engineering]: http://c42.in
[Haml markup]: http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html

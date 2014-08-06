# visual-environments

Automatic visual, in-browser cues about your current environment for Rails 3 applications!

If you're a developer accustomed to working across multiple development and staging environments, you have certainly been in the position where you have multiple browser windows/tabs open with the same site but pointing at different environments.  This gem aims to help you keep your contexts straight!

This is a configurable means for showing, via an updated &lt;title&gt; tag or CSS corner banner overlay, what the current runtime environment is (development, staging, test, etc.)  This functionality is never enabled for production, and fully configurable to exclude other environments as well.

# Install & Configuration

Add the following to your Rails application's Gemfile

```ruby
gem 'visual-environments'
```

...and run `bundle install`.  Then use the visual-environments generator to install the configuration file to your `config/initializers` directory:
```sh
$ rails g visual_environments:install
```

There should now be a new file `config/initializers/visual-environments.rb` with the content:

```ruby
VisualEnvironments.setup do |config|
  # Turns on the display of the current environment in the title tag of each page in the app
  config.enable_env_in_title = true

  # Uncomment the line below and select which side to display the banner on.  Current possible
  # values are (:right, :left) corresponding to upper-right and upper-left corners, respectively
  # config.corner_banner_side = :right

  # By default, the full environment name is used in the visual cues (development, test, etc.)  You
  # can map environment names by using the below setting to alias one environment name to another.
  # Using the option below configures the alias for both the title tag and the corner banner display;
  # if you would like different strings for each area then see the next section.
  # Example: 'development' -> 'dev' or 'preproduction' -> 'preprod'
  # config.aliases = { 'development' => 'dev' }

  # You may alternatively declare different aliases for the title tag versus the corner banner
  # using the options below.
  # config.title_aliases = { 'development' => 'dev' }
  # config.corner_banner_aliases = { 'preproduction' => 'preprod' }

  # By default, the visual-environments will be enabled for all environments except production;
  # to exclude additional environments, uncomment the line below and add them to the collection
  # config.excluded_environments = []

  # The following layout defaults can alow be overridden
  #
  # config.banner_font = "Verdana"
  # config.banner_font_size = "10px"
  # config.banner_foreground_colour = "#fff"
  # config.banner_background_colour = "#000"
  # config.banner_zindex = 1040
end
```

By default, visual environments are enabled in the page title but disabled for corner banner display.  Also, by default only production environments are excluded from the gem functionality.

## Excluding Environments

You can add additional environments to be excluded by adding their names to the `excluded_environments` collection.  For example, let's say you have an app with a test-oriented staging environment as well as a 'almost-ready-for-prime-time' preproduction environment.  In this case you may want the visual cues on the staging but not on preproduction.  In that case you can edit the initializer to:

```ruby
config.excluded_environments = ['preproduction']
```

And now preproduction will not use the visual-environments functionality.

## Corner Banner & Changing the Side of the Banner

The corner banner is not included by default.  To enable it, choose which side it should be displayed on via the `corner_banner_side` option in `config/initializers/visual-environments.rb`:

```ruby
config.corner_banner_side = :right
```

Valid options are currently `:left` and `:right`, corresponding to the upper-left and upper-right corners, respectively.

## Aliasing Environment Names

Having the string "[development]" prepended to your title may make things a bit unwieldy for some people.  In that case, you may use the aliasing option to change such an identifier to something shorter (but still identifiable with the environment in question).  For example, you can alias 'development' to 'dev' or 'D', which would result in "[dev]" or "[D]" being prepended to the page title.

To add an alias that is used both in the title and the banner, uncomment and set the `aliases` setting as follows:

```ruby
config.aliases = { 'development' => 'dev', 'preproduction' => 'preprod' }
```

The above example would show use 'dev' in a development environment and 'preprod' in a preproduction environment.  The point is, you can alias any environment you may use, not just the out-of-the-box environments Rails uses (development, test, production).

You can also set the aliases for ONLY the title or ONLY the corner banner.  For example, I like the full environment used in the banner but like the title identifier to be much shorter:

```ruby
config.title_aliases = { 'development' => 'D', 'staging' => 'S' }
```

You can do the same to change the alias of the corner banner:

```ruby
config.corner_banner_aliases = { 'development' => 'dev', 'preproduction' => 'preprod' }
```

# Contributing to visual-environments

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Changelog

* 3 April, 2013: Update README formatting, modernize gemspec definitions.
* 14 March, 2011: Added tests. Run <tt>rake spec</tt> to run 'em.
* 5 March, 2011: Changed format of initializer, added ability to alias title and corner banner strings independently, refactored internal structure of the module, updated docs.  This is a NON-BACKWARDS COMPATIBLE update; you must rerun <tt>rails g visual_environments:install</tt> to regenerate a new initializer file and then reset your options.
* 27 February, 2011: Updated source_root definition, fixing bug in initializer
* 20 February, 2011: Added generator, documented configuration options, added ability to switch corner banner from left to right side
* 19 February, 2011: Initial revision- a result of the MadRailers Coding Day!

# Copyright

Copyright &copy; 2011-2013 Zachery Moneypenny, David van Leeuwen. See LICENSE.txt for further details.

Many thanks to the Mad-Railers for their idea for this gem! If you're coding Ruby/Rails in the Madison, Wisconsin area search for [MadRailers on meetup.com](http://www.meetup.com/Mad-Railers/) or check out the [Google Group at http://groups.google.com/group/Mad-Railers](http://groups.google.com/group/Mad-Railers).
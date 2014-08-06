VisualEnvironments.setup do |config|
  # Turns on the display of the current environment in the title tag of each page in the app
  config.enable_env_in_title = true

  # Uncomment he line below and select which side to display the banner on.  Current possible 
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

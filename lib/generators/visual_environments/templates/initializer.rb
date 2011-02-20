ActionController::Base::VisualEnvironments.enable_env_in_title = true

# By default, the corner banner is disabled
ActionController::Base::VisualEnvironments.enable_env_in_corner_banner = false
# By default, if the corner banner is enabled it is shown on the right side of the page.  For
# those pages where it would be better for it to reside in the upper-left corner, uncomment
# the line below and change the argument to :left.  Current possible values are (:right, :left)
# ActionController::Base::VisualEnvironments.corner_banner_side = :right

# By default, the full environment name is used in the visual cues (development, test, etc.)  You
# can map environment names by using the below setting to alias one environment name to another
# Example: 'development' -> 'dev' or 'preproduction' -> 'preprod'
# ActionController::Base::VisualEnvironments.aliases = { 'development' => 'dev' }

# By default, the visual-environments will be enabled for all environments except production;
# to exclude additional environments, uncomment the line below and add them to the collection
# ActionController::Base::VisualEnvironments.excluded_environments = []

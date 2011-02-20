ActionController::Base::VisualEnvironments.enable_env_in_title = true

# Uncomment he line below and select which side to display the banner on.  Current possible 
# values are (:right, :left) corresponding to upper-right and upper-left corners, respectively
ActionController::Base::VisualEnvironments.corner_banner_side = :right

# By default, the full environment name is used in the visual cues (development, test, etc.)  You
# can map environment names by using the below setting to alias one environment name to another
# Example: 'development' -> 'dev' or 'preproduction' -> 'preprod'
# ActionController::Base::VisualEnvironments.aliases = { 'development' => 'dev' }

# By default, the visual-environments will be enabled for all environments except production;
# to exclude additional environments, uncomment the line below and add them to the collection
# ActionController::Base::VisualEnvironments.excluded_environments = []

module VisualEnvironments
 
 # Whether the current environment should be shown in the title tag
 mattr_accessor :enable_env_in_title
 @@enable_env_in_title = false
 
 # If non-nil, describes which side of the page the banner should be
 # displayed on (valid values are :left, :right)
 mattr_accessor :corner_banner_side
 @@corner_banner_side = nil
 
 # Allows config to map different strings to the environments displayed
 # in the title tag
 mattr_accessor :title_aliases
 @@title_aliases = {}

 # Allows config to map different strings to the environments displayed
 # in the corner banner display 
 mattr_accessor :corner_banner_aliases
 @@corner_banner_aliases = {}
 
 # A collection of environments that this gem should not operate in
 mattr_accessor :excluded_environments
 @@excluded_environments = []
 
 # The font to render the banner text
 mattr_accessor :banner_font
 @@banner_font = "Verdana"

 # The font size for the banner text
 mattr_accessor :banner_font_size
 @@banner_font = "10px"
 
 # The text colour of the banner
 mattr_accessor :banner_foreground_colour
 @@banner_foreground_colour = "#fff"

 # The background color of the banner
 mattr_accessor :banner_background_colour
 @@banner_background_colour = "#000"
 
 # The z-index of the banner
 mattr_accessor :banner_zindex
 @@banner_zindex = 1040

 # Use setup with a block to configure the module in an initializer;
 # run 'rails generate visual_environments:install' to create a default
 # initializer
 def self.setup
   yield self
 end
 
 # Set the aliases of both the title and the corner
 # banner to the supplied item
 def self.aliases=(aliases)
   @@title_aliases.replace aliases
   @@corner_banner_aliases.replace aliases
 end
 
 def shim_visual_environments
   unless Rails.env == 'production' || (VisualEnvironments.excluded_environments && VisualEnvironments.excluded_environments.include?(Rails.env))
     
     # Only mess with HTML
     return unless response.content_type == 'text/html'
     
     if VisualEnvironments.enable_env_in_title
       current_env = Rails.env
       current_env = VisualEnvironments.title_aliases[current_env] if !VisualEnvironments.title_aliases.nil? && VisualEnvironments.title_aliases.has_key?(current_env)
       shim = "<script type='text/javascript'>var te=document.getElementsByTagName('title')[0];var t=te.innerHTML;te.innerHTML=\"["+current_env+"] \"+t;</script></body>"
       response.body = response.body.gsub /\<\/body\>/, shim
     end
   
     unless VisualEnvironments.corner_banner_side.nil?
       # Exit if we detect invalid options in the corner_banner_side option
       return unless [:left,:right].include?(VisualEnvironments.corner_banner_side)
       current_env = Rails.env
       current_env = VisualEnvironments.corner_banner_aliases[current_env] if !VisualEnvironments.corner_banner_aliases.nil? && VisualEnvironments.corner_banner_aliases.has_key?(current_env)
       shim = "<script type='text/javascript'>var con=document.createElement('div');con.id='VisualEnvironment_container';document.body.appendChild(con);var ce=document.createElement('div');ce.id='VisualEnvironment_corner';ce.innerHTML='"+current_env+"';con.appendChild(ce);</script>"
       
       if VisualEnvironments.corner_banner_side == :right
         shim += "<style>#VisualEnvironment_corner{position:absolute;top:20px;right:-35px;font-family:#{@@banner_font};font-size:#{@@banner_font_size};color:#{@@banner_foreground_colour};padding:9px;width:120px;text-align:center;background:#{@@banner_background_colour};border:#fff 1px solid;filter:alpha(opacity=70);-moz-opacity:0.7;-khtml-opacity:0.7;opacity:0.7;-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);}#VisualEnvironment_container{position:absolute;top:0;right:0;width:120px;height:93px;overflow:hidden;z-index:#{@@banner_zindex}}</style>"
       elsif VisualEnvironments.corner_banner_side == :left
         shim += "<style>#VisualEnvironment_corner{position:absolute;top:20px;left:-35px;font-family:#{@@banner_font};font-size:#{@@banner_font_size};color:#{@@banner_foreground_colour};padding:9px;width:120px;text-align:center;background:#{@@banner_background_colour};border:#fff 1px solid;filter:alpha(opacity=70);-moz-opacity:0.7;-khtml-opacity:0.7;opacity:0.7;-webkit-transform:rotate(-45deg);-moz-transform:rotate(-45deg);}#VisualEnvironment_container{position:absolute;top:0;left:0;width:120px;height:93px;overflow:hidden;z-index:#{@@banner_zindex}}</style>"
       end
       shim += "</body>"
       response.body = response.body.gsub /\<\/body\>/, shim
     end  
     
   end
 end

end

class ActionController::Base
  include VisualEnvironments
  after_filter :shim_visual_environments  
end

class ActionController::Base
  after_filter :shim_visual_environments  
  
  def shim_visual_environments
    unless Rails.env == 'production' || (VisualEnvironments.excluded_environments && VisualEnvironments.excluded_environments.include?(Rails.env))
      if VisualEnvironments.enable_env_in_title
        shim = "<script type='text/javascript'>var te=document.getElementsByTagName('title')[0];var t=te.innerHTML;te.innerHTML=\"["+Rails.env+"] \"+t;</script></body>"
        response.body.gsub! /\<\/body\>/,  shim
      end
    
      if VisualEnvironments.enable_env_in_corner_banner
        shim = "<script type='text/javascript'>var con=document.createElement('div');con.id='VisualEnvironment_container';document.body.appendChild(con);var ce=document.createElement('div');ce.id='VisualEnvironment_corner';ce.innerHTML='"+Rails.env+"';con.appendChild(ce);</script><style>#VisualEnvironment_corner{position:absolute;top:20px;right:-35px;font-family:Verdana;font-size:10px;color:#fff;padding:9px;width:120px;text-align:center;background:#000;border:#fff 1px solid;filter:alpha(opacity=70);-moz-opacity:0.7;-khtml-opacity:0.7;opacity:0.7;-webkit-transform:rotate(45deg);-moz-transform:rotate(45deg);}#VisualEnvironment_container{position:absolute;top:0;right:0;width:120px;height:93px;overflow:hidden;}</style></body>"
        response.body.gsub! /\<\/body\>/,  shim
      end  
    end
  end
  
  module VisualEnvironments
    class << self
      attr_accessor :enable_env_in_title, :enable_env_in_corner_banner
      attr_accessor :excluded_environments 
    end
  end
end
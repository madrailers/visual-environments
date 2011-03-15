require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe MyController do
  include RSpec::Rails::ControllerExampleGroup
  include RSpec::Rails::Matchers
  
  it 'should call the before_filter method in ActionController::Base' do
    controller.should_receive(:shim_visual_environments).once
    get :index
  end
  
  describe 'title tag manipulation' do
    
    before(:each) do
      VisualEnvironments.setup do |config|
        # Turns on the display of the current environment in the title tag of each page in the app
        config.enable_env_in_title = true
      end
      Rails.env = 'test'
    end
    
    it 'should add the javascript to prepend the current environment to the title tag' do
      get :index
      response.body.should contain("var te=document.getElementsByTagName('title')[0];")
    end
    
    it 'should use the current environment in the title tag' do
      # Run as default environment (test)
      get :index
      response.body.should contain("te.innerHTML=\"[test] \"+t;")
      # Reset the current environment to something else
      Rails.env = 'staging'
      get :index
      response.body.should contain("te.innerHTML=\"[staging] \"+t;")
    end
    
    it 'should honor the aliases set in the config' do
      VisualEnvironments.aliases = { 'test' => 'T' }
      get :index
      response.body.should contain("te.innerHTML=\"[T] \"+t;")    

      VisualEnvironments.title_aliases = { 'test' => 'TESTERLICIOUS' }  
      get :index
      response.body.should contain("te.innerHTML=\"[TESTERLICIOUS] \"+t;")
    end
    
    it 'should not do anything when in the production environment' do
      Rails.env = 'production'
      get :index
      response.body.should_not contain("var te=document.getElementsByTagName('title')[0];")
    end
  end
  
  describe 'corner banner generation' do
    
    before do
      # Turn off the title tags for these tests
      VisualEnvironments.stub(:enable_env_in_title).and_return(false)
      # Reset to the test environment before each test, since some change it
      Rails.env = 'test'
      # Set the right and left expected css to check for
      @right_corner_check = "VisualEnvironment_corner{position:absolute;top:20px;right:"
      @left_corner_check = "VisualEnvironment_corner{position:absolute;top:20px;left:"
      # Format string to testing the strings shown in the corner banner
      @corner_banner_format = "ce.innerHTML='%s';"
    end
    
    it 'should not include the corner banner unless the config was uncommented' do
      VisualEnvironments.stub(:corner_banner_side).and_return(nil)
      get :index
      response.body.should_not contain(@right_corner_check)
      response.body.should_not contain(@left_corner_check)
    end
    
    it 'should correctly place the banner on the right side if the setting is :right' do
      VisualEnvironments.stub(:corner_banner_side).and_return(:right)
      get :index
      response.body.should contain(@right_corner_check)
    end
    
    it 'should correctly place the banner on the left side if the setting is :left' do
      VisualEnvironments.stub(:corner_banner_side).and_return(:left)
      get :index
      response.body.should contain(@left_corner_check)
    end
    
    it 'should display the environment name in the banner' do
      VisualEnvironments.stub(:corner_banner_side).and_return(:right)
      VisualEnvironments.stub(:corner_banner_aliases).and_return(nil)
      get :index      
      response.body.should contain( sprintf(@corner_banner_format, Rails.env) )      
    end
    
    it 'should honor the aliases for the banner value that are set in the config' do
      VisualEnvironments.stub(:corner_banner_side).and_return(:right)
      VisualEnvironments.stub(:corner_banner_aliases).and_return({'test' => 'TESTAH'})
      get :index
      response.body.should contain( sprintf(@corner_banner_format, 'TESTAH') )
    end
      
    
    it 'should not do anything when in production' do
      VisualEnvironments.stub(:corner_banner_side).and_return(:right)
      Rails.env = 'production'
      get :index
      response.body.should_not contain( sprintf(@corner_banner_format, Rails.env) )
    end
    
    
  end
  
  
  
  
  
  
  
end

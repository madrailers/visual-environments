module VisualEnvironmentsTest
  class Application < Rails::Application ; end
end

VisualEnvironmentsTest::Application.routes.draw do
  match '/:controller(/:action(/:id))'
end

ActionController::Base.send :include, VisualEnvironmentsTest::Application.routes.url_helpers

class MyController < ActionController::Base
  def index
    html = <<-MYHTML
      <html>
        <head><title>My Title</title></head>
        <body>My Body</body>
      </html>
    MYHTML
    render :text => html
  end

  def image
    send_data 'some image', type: 'image/gif', disposition: 'inline'
  end
end


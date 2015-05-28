class SimpleRack

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    # You can tweak the params as you want
    return [200, {}, ["Yo baby!"]]
  end

  # hook / unhook this in application.rb file

end
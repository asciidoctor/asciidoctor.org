require 'chunky_png'
require 'base64'

module Sass::Script::Functions
  # TODO document me
  def string_to_color(name)
    # FIXME check to see if a color could be found, don't just assume
    Sass::Script::Color.new Sass::Script::Color::COLOR_NAMES[name.value]
  end

  # background_noise from https://gist.github.com/aaronrussell/856571 by Aaron Russell
  def background_noise(c, noise = 0.5, opacity = 0.08, size = 200, mono = false)
     
    # Convert SASS numbers to Ruby classes
    noise   = noise.to_s.to_f   if noise.is_a? Sass::Script::Number
    opacity = opacity.to_s.to_f if opacity.is_a? Sass::Script::Number
    size    = size.to_i         if size.is_a? Sass::Script::Number
    mono    = mono.to_bool      if mono.is_a? Sass::Script::Bool
    
    # Create the background image
    bg_color = ChunkyPNG::Color.rgba(c.red, c.green, c.blue, (c.alpha * 255).round)
    bg_image = ChunkyPNG::Image.new(size, size, bg_color)
    
    # Create a transparent foreground image
    fg_image = ChunkyPNG::Image.new(size, size)
    
    # Add some noise to the foreground image
    for i in (0..(noise * (size**2)))
      x = rand(size.to_i)
      y = rand(size.to_i)
      r = rand(255)
      a = rand(255 * opacity)
      color = mono ? ChunkyPNG::Color.rgba(r, r, r, a) : ChunkyPNG::Color.rgba(r, rand(255), rand(255), a)
      fg_image.set_pixel(x, y, color)
    end
    
    # Mix it up
    image = bg_image.compose(fg_image)
    
    # Save the image - will eventually save to a file but for now
    # a base64 data url will do...
    data = Base64.encode64(image.to_blob).gsub("\n", "")
    Sass::Script::String.new("url('data:image/png;base64,#{data}')")
     
  end
end

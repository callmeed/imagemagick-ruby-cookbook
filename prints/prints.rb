# Print prep
# This takes all the images in the directory and creates new images at a specific size
# Some printers require exact sizes/resolutions in order to get discount pricing



# Get all the JPG images in the current directory
images = Dir['*.jpg']

# Log number of images
puts "There are #{images.size} images"

# Loop and build the ImageMagick command
images.each_with_index do |image, index|

  # Measure the time 
  start_time = Time.now

  # These are the specs we need
  # Change accordingly
  width_in_inches = 4
  height_in_inches = 4
  resolution = 300
  width = resolution * width_in_inches
  height = resolution * height_in_inches

  # Sharpening
  # See: http://www.imagemagick.org/Usage/blur/#sharpen
  sharpening = "0x1.0"


  final = "final-" + index.to_s + ".jpg"
  kommand = "convert #{image} -resize #{width}x#{height} -sharpen #{sharpening} -density #{resolution} -gravity center -background white #{final}"

  # Log the final command
  puts "Final command is: "
  puts kommand

  # Run the command in shell
  result = `#{kommand}`

  puts "Completed this image in #{Time.now - start_time} seconds"

end

# Log any output
puts "Operation complete. Results:"

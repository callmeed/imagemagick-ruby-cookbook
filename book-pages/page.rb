# Get all the JPG images in the current directory
images = Dir['*.jpg']

# Log number of images
puts "There are #{images.size} images"

# Loop and build the ImageMagick command
images.each_with_index do |image, index|

  # Measure the time 
  start_time = Time.now

  final = "page-" + index.to_s + ".jpg"
  kommand = "convert #{image} -resize 1200x1200 -gravity center -background white -extent 1575x1575 #{final}"

  # Log the final command
  puts "Final command is: "
  puts kommand

  # Run the command in shell
  result = `#{kommand}`

  puts "Completed this image in #{Time.now - start_time} seconds"

  # Do a 4-up every 10 images just for kicks
  if index % 10 == 0

    i1 = image
    i2 = images[index + 1]
    i3 = images[index + 2]
    i4 = images[index + 3]
    final = "page-" + index.to_s + "-4up.jpg"
    kommand = "convert -size 1575x1575 xc:white #{i1} -geometry 600x600+125+125 -composite #{i2} -geometry 600x600+125+850 -composite #{i3} -geometry 600x600+850+125 -composite #{i4} -geometry 600x600+850+850 -composite #{final}"

    result = `#{kommand}`

  end

end

# Log any output
puts "Operation complete. Results:"

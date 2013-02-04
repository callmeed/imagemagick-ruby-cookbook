# Measure the time 
start_time = Time.now

# Get all the JPG images in the current directory
images = Dir['*.jpg']

# Log number of images
puts "There are #{images.size} images"

# Build the ImageMagick command
# We're using montage here
# Final file name will be timestamp based
final = "final-" + Time.now.to_i.to_s + ".jpg"
kommand = "montage -geometry 1800x1800+0+0 " + images.join(" ") + " " + final

# Log the final command
puts "Final command is: "
puts kommand

# Run the command in shell
result = `#{kommand}`

# Log any output
puts "Operation complete in #{Time.now - start_time} seconds. Results:"
puts result
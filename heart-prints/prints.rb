require 'open-uri'
require 'json'
require 'shellwords'
# Prints builder
# This takes a few image IDs from Instagram, uses the API to get info
# and creates-print ready files with extra whitespace that shows the 
# number of likes


# Get user's recent images from API 
# url = "https://api.instagram.com/v1/users/10206679/media/recent?access_token=1830757.9f03f99.f688ba1467b14b409c03407601c198c3"
url = "https://api.instagram.com/v1/users/1830757/media/recent?access_token=1830757.9f03f99.f688ba1467b14b409c03407601c198c3&max_id=347858399738452430_1830757"
result = JSON.parse(open(url).read)

puts "Next URL is: " + result['pagination']['next_url']

result['data'].each_with_index do |image, index|

  image_url = image['images']['standard_resolution']['url']
  image_name = image['id'] + '.jpg'
  image_likes = image['likes']['count']

  image_caption = image['caption'].class == Hash ? image['caption']['text'] : ""
  
  puts "Saving #{image_name} ..."

  puts "Caption is: #{image_caption}"

  open(image_url) do |f|
    File.open(image_name, 'wb') do |file|
      file.puts f.read
    end
  end

  # Create the caption as a separate file
  if image_caption > ''
    caption_file = 'caption-' + image['id'] + '.png'
    kommand = "convert -size 1000x250 -pointsize 55 -font \"PermanentMarker.ttf\" xc:white caption:'#{Shellwords.escape(image_caption)}' -composite #{caption_file}"
    puts kommand
    result = `#{kommand}`
    # Create the new file w/ caption
    final_name = 'final-' + image_name
    kommand = "convert -quality 90 -size 1050x1500 -density 300 xc:white -fill \"#aaaaaa\" -pointsize 32 -draw \"text 155,1201 '#{image_likes}'\" #{image_name} -geometry 1000x1000+25+25 -composite heart.png -geometry +25+1100 -composite #{caption_file} -geometry +25+1250 -composite #{final_name}"
    puts kommand
    result = `#{kommand}`
  else
    # Create the new file w/o caption
    final_name = 'final-' + image_name
    kommand = "convert -quality 90 -size 1050x1500 -density 300 xc:white -fill \"#aaaaaa\" -pointsize 32 -draw \"text 155,1201 '#{image_likes}'\" #{image_name} -geometry 1000x1000+25+25 -composite heart.png -geometry +25+1100 -composite #{final_name}"
    puts kommand
    result = `#{kommand}`
  end

  
end

# Get all the JPG images in the current directory


# # Log number of images
# puts "There are #{images.size} images"

# # Loop and build the ImageMagick command
# images.each_with_index do |image, index|

#   # Measure the time 
#   start_time = Time.now

#   final = "page-" + index.to_s + ".jpg"
#   kommand = "convert #{image} -resize 1200x1200 -gravity center -background white -extent 1575x1575 #{final}"

#   # Log the final command
#   puts "Final command is: "
#   puts kommand

#   # Run the command in shell
#   result = `#{kommand}`

#   puts "Completed this image in #{Time.now - start_time} seconds"

#   # Do a 4-up every 10 images just for kicks
#   if index % 10 == 0

#     i1 = image
#     i2 = images[index + 1]
#     i3 = images[index + 2]
#     i4 = images[index + 3]
#     final = "page-" + index.to_s + "-4up.jpg"
#     kommand = "convert -size 1575x1575 xc:white #{i1} -geometry 600x600+125+125 -composite #{i2} -geometry 600x600+125+850 -composite #{i3} -geometry 600x600+850+125 -composite #{i4} -geometry 600x600+850+850 -composite #{final}"

#     result = `#{kommand}`

#   end

# end

# # Log any output
# puts "Operation complete. Results:"

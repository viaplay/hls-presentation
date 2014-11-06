require 'rubygems'
require 'fileutils'

# Configure these
source_filename = "input.mov"
output_url = "https://example.com/hls"
bitrates = [200, 500, 1000, 1500]

# Create output directory
FileUtils.mkdir_p 'output'

# Transcode the video once for each bitrate
bitrates.each do |bitrate|
	output_path = "output/#{bitrate}.ts"

	# ffmpeg options
	ffmpeg_params = [
		"-vcodec libx264", # Encode to H264 using libx264
		"-acodec libfaac", # Encode to AAC using libfaac
		"-b:v #{bitrate}k", # Set the video bitrate
		"-b:a 64k", # Set the audio bitrate
		"-threads 0" # Run multi-threaded
	]

	# Transcode using ffmpeg
	# ffmpeg will automatically detect output container by file extension (ie. TS container in this case)
	system("ffmpeg -i #{source_filename} #{ffmpeg_params.join(' ')} #{output_path}")

	# Split video into segments
	# It will create a layer playlist named like "layer_500.m3u8" and name the segments like "layer_500_1.ts"
	# A plist file will be created to use later when we're generating the master playlist
	system("mediafilesegmenter -I -z none -f output/ -i layer_#{bitrate}.m3u8 -B layer_#{bitrate}_ #{output_path}")

	# Remove transcoded video file
	File.delete(output_path)
end

# Create master playlist
# variantplaylistcreator takes each layer as an argument in the form of "output/layer_500.m3u8 output/layer_500.plist"
layers = bitrates.map {|bitrate| "#{output_url}/layer_#{bitrate}.m3u8 output/#{bitrate}.plist" }
system("variantplaylistcreator -o output/master.m3u8 #{layers.join(' ')}")

# Remove temporary files needed for creating the master playlist
bitrates.each {|bitrate| File.delete("output/#{bitrate}.plist") }

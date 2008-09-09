
# IcyRuby created by Garrett Kelly
# Based on a ruby snippet created by Leonardo Guilherme de Freitas who thanks Phil Devitt
# see original :: http://rubyforge.org/snippet/detail.php?type=snippet&id=112
# -------------------------------------------
require 'socket'
class IcyRuby
  
    def self.start
        start_up do
            stream_icy_server
            return
        end
    end
    
    def self.start_up(&block)
        fork(&block)
    end
    
    def self.stream_icy_server
        @@icy_config_path = (RAILS_ROOT + '/config/icy.yml')
        @@icy_config = @@icy_config = YAML.load(ERB.new(File.read(@@icy_config_path)).result)[RAILS_ENV].symbolize_keys

        host =  @@icy_config[:host]
        path =  @@icy_config[:path]

         # Try to connect
        stream = TCPSocket.open(host,  @@icy_config[:port])
        puts "Sending headers..."
        stream.puts "Get #{path} HTTP/1.1"
        stream.puts "Host: #{host}"
        stream.puts "User-Agent: RSR"
        stream.puts "Icy-MetaData:1"
        stream.puts "\r\n"
        puts "Waiting for stream info from #{host}"



        header = nil
        while (header != "\r\n") do
        	header = stream.gets
        	puts header
        	split_header = header.split(":")
        	if (split_header[0].downcase == "icy-metaint")
        		metaint = split_header[1].to_i
        	end
        	if (split_header[0].downcase == "icy-name")
        		stream_name = split_header[1].chomp
        	end
        end
        directory = "[RSR]" + stream_name unless stream_name.nil?


        puts "Stream name: #{stream_name}"
        puts "Waiting for data."

        title = "unamed"; old_title = "unamed"; file = nil

        # Streaming...
        loop do
        	# Read 'metaint' amount of data
        	data = stream.read(metaint)
        	if (file != nil); file.write(data); end

        	# Get the lenght of the title
        	# Read 1 byte of data, and convert it into an ASCII value
        	title_size = stream.read(1)[0]

        	# Multiplies the 'title_size' to get the real title size
        	# and then read that amount of data, the title itself.
        	title_size *= 16
        	raw_title = stream.read(title_size)

        	# Any real title here?
        	if (raw_title != "")
        		# Strip the raw title
        		less_raw_title = raw_title.split(";").first.split("=")
        		title = less_raw_title[1].gsub(/'/, '')
        		filename = "#{Time.now.strftime("%x %X").gsub("/",".")} - #{title}.mp3"
        		# Check if the title has changed
        		if (title != old_title)
        			old_title = title
        			if (file != nil); file.close; end
        			puts "Song: #{title}"
        		end
        	end
        end
    end
end
#!/usr/bin/env ruby 

# == Author
#   Camillo Bruni
#
# == Copyright
#   Copyright (c) Camillo Bruni 2011. Licensed under the MIT License:
#   http://www.opensource.org/licenses/mit-license.php
#   Original template from http://blog.infinitered.com/entries/show/5


require 'optparse' 
require 'ostruct'
require 'date'
require 'logger'  


class App
    VERSION = '0.0.1'
    
    attr_reader :options

    def initialize(arguments, stdin)
        @arguments = arguments
        @stdin     = stdin
        
        # Set defaults
        @options = OpenStruct.new
        @options.send_message = true
        @options.verbose      = false
        @options.quiet        = false
    end

    def run
        # Specify options
        @opts = OptionParser.new do |opts|
            opts.program_name = 'todo'
            opts.version = '0.1'
            opts.banner = 'todo [options] comment'

            opts.on("--[no-]send", "Send the message") do |v|
                @options.send_message = v
            end
            
            opts.separator ""
            opts.separator "Common options:"

            opts.on_tail("-h", "--help", "Show this message") do
                puts opts
                exit
            end

            opts.on_tail("--version", "Show version") do
                puts opts.version
                exit
            end

            opts.on_tail('--hack', "Edit the programs source") { self.hack }
        end
        
        if ARGV.empty?
            puts @opts
            exit
        end

        @opts.parse!(@arguments)
        self.process_command
    end
    
    protected
    def process_command
        IO.popen('osascript', 'w') { |f|
        f.puts <<EOF
            -- Variables
            set recipientAddress to "#{self.email}"
            set theSubject to "TODO: #{ARGV.join(' ')}"
            --Invoke Mail
            tell application "Mail"
            	set theMessage to make new outgoing message with properties {subject:theSubject, visible:true}
            	tell theMessage
            		make new to recipient with properties {address:recipientAddress}
            		--Send the Message
                    #{@options.send_message ? 'send' : ''}
            	end tell
                #{@options.send_message ? '' : 'activate'}
            end tell
EOF
    }
    end


    def email
        return ENV['TODO_EMAIL'] if ENV['TODO_EMAIL']
        return ENV['EMAIL'] if ENV['EMAIL']
        @opts.abort 'Could not find $EMAIL ENV var'
    end


    def editor
        if ENV['EDITOR']
            return ENV['EDITOR']
        else
            return 'vim'
        end
    end

    def hack
        sourceFile = `readlink #{__FILE__} || echo #{__FILE__}`.chomp
        exec(self.editor, sourceFile)
    end
end

# ============================================================================

if __FILE__ == $0
    # preamble to change to the current scripts dir
    def dir
        begin 
            return File.readlink $0
        rescue
            return $0
        end
    end
    DIR = Dir.chdir File.dirname dir
    
    # Create and run the application
    app = App.new(ARGV, STDIN)
    app.run
end

require 'colorize'
require 'readline'

require './lib/commands'
require './lib/functions'
require './model/input'

LIST = Commands::COMMANDS.keys.sort

comp = proc { |s| LIST.grep(/^#{Regexp.escape(s)}/) }

Readline.completion_append_character = ' '
Readline.completion_proc = comp

stty_save = %x`stty -g`.chomp
trap('INT') { system 'stty', stty_save, exit }

Functions.start_anew

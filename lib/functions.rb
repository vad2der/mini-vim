require 'readline'

class Functions
  def self.return_help
    result = "\nAvailable commands:\n".colorize(:green)
    result += format(
      "%5<a>s %-10<b>s %-20<c>s %<d>s\n",
      { a: ' ', b: 'COMMAND', c: 'ALIASES', d: 'DESCRIPTION' }
    )
    result + formatted_commands.join('')
  end

  def self.formatted_commands
    Commands::COMMANDS.map do |k, v|
      format(
        "%5<a>s %-10<b>s %-20<c>s %<d>s\n",
        {
          a: ' ', b: k,
          c: v[:aliases]&.join(', ') || '',
          d: v[:desc].colorize(:yellow)
        }
      )
    end
  end

  def self.exit_cli
    puts 'User initiated exit'.colorize(:green)
    exit
  end

  def self.start_anew
    puts 'New input initiated'.colorize(:green)
    @input = new_input

    check_forbidden_chars

    while (command = Readline.readline('Command: '.colorize(:magenta), true))
      puts 'Output: '.colorize(:magenta) + Commands.processed_output(
        @input, command
      )
      puts "\n"
    end
  end

  def self.new_input
    Input.new(
      Readline.readline('Input Text: '.colorize(:magenta), true)
    )
  end

  def self.check_forbidden_chars
    Commands::FORBIDDEN_CARS.each do |c|
      next unless @input.body.include?(c)

      puts Commands.unacceptable_chars_message(c)
      GC.start
      @input = new_input
    end
  end
end

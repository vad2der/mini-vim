require 'colorize'
require '../lib/functions'
require '../lib/commands'
require '../model/input'

RSpec.describe Functions do
  it 'help printout' do
    expect(described_class.return_help).to include('Available commands:')
  end

  # it 'exits printout' do
  #   expect(described_class.exit_cli).to include('User initiated exit')
  # end
end

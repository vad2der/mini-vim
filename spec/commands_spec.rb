require '../lib/commands'
require '../lib/functions'
require 'colorize'
require '../model/input'

RSpec.describe Commands do
  let(:unnaceptable_char) { ']' }
  let(:unnaceptable_char_message) do
    'Unacceptable char: ' + unnaceptable_char.colorize(:red) +
      ' is found in the input. Fix the input.'
  end
  let(:unknown_commnad) { 'abirvalg' }
  let(:unknown_commnad_message) do
    'Unknown command ' + unknown_commnad.colorize(:red) +
      ' Type "h" command for help.'
  end

  it 'has a Hash or commands' do
    expect(described_class::COMMANDS).to be_instance_of(Hash)
  end

  it 'has a Hash that is frozen' do
    expect(described_class::COMMANDS.frozen?).to be_truthy
  end

  it 'has a Hash in a value with specific keys' do
    described_class::COMMANDS.each do |_, v|
      expect(v).to be_instance_of(Hash)
      expect(v.keys.sort).to eq(%i[aliases desc])
    end
  end

  it 'returns unnaceptable char message' do
    expect(described_class.unacceptable_chars_message(unnaceptable_char)).to eq(
      unnaceptable_char_message
    )
  end

  context 'when a command supplied' do
    let(:input) { Input.new('abirvalg') }

    it 'handels a valid command' do
      expect(described_class.processed_output(input, 'help')).to include(
        'Available commands:'
      )
    end

    it 'points to help if invalid command supplied' do
      expect(described_class.processed_output(input, unknown_commnad)).to eq(
        unknown_commnad_message
      )
    end
  end
end

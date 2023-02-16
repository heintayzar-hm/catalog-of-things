require_relative 'helper_module'

class LabelModule
  include ColorTerminal
  def initialize
    @labels = load_labels
  end
  attr_accessor :labels

  def load_labels
    return [] if File.read(File.join('data', 'labels.json')).empty?

    JSON.parse(File.read(File.join('data', 'labels.json')))
  end

  def list_all_labels
    return puts red('There are no labels in the catalog') if @labels.empty?

    @labels.each_with_index do |label, index|
      puts "#{blue((index + 1).to_s)}) Title: #{blue(label['title'])}, Color: #{blue(label['color'])}"
    end
  end

  def get_label(id)
    @labels.find { |label| label['id'] == id }['title']
  end
end

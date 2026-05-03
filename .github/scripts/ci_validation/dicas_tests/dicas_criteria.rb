# Define criteria for dicas UI tests
class DicasCriteria
  def initialize
    @criteria = {
      tooltip: {
        displayed: false,
        hover: true
      },
      modal: {
        displayed: false,
        click: true
      },
      ajuda: {
        displayed: false,
        help_button: true
      }
    }
  end

  def evaluate_criteria
    # Evaluate the criteria for each test case
    @criteria.each do |component, criteria|
      if criteria[:displayed]
        puts "Criteria for #{component} met: displayed"
      elsif criteria[:hover] || criteria[:click] || criteria[:help_button]
        puts "Criteria for #{component} met: #{criteria[:hover] ? 'hover' :(criteria[:click] ? 'click' : 'help_button')}"
      else
        puts "Criteria for #{component} not met"
      end
    end
  end
end

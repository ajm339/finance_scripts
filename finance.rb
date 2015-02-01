class PresentFutureValue
  attr_reader :attributes

  def initialize(params)
    @attributes = Hash.new
    @attributes['future_value'] = if params['future_value'].nil? then nil else params['future_value'].to_f end
    @attributes['present_value'] = if params['present_value'].nil? then nil else params['present_value'].to_f end
    @attributes['rate'] = if params['rate'].nil? then nil else params['rate'].to_f end
    @attributes['time'] = if params['time'].nil? then nil else params['time'].to_f end
  end

  def calculate
    if @attributes['future_value'].nil?
      calculation = "Future Value"
      value = calc_future_value(@attributes)
    elsif @attributes['present_value'].nil?
      calculation = "Present Value"
      value = calc_present_value(@attributes)
    elsif @attributes['rate'].nil?
      calculation = "Rate"
      value = calc_rate(@attributes)
    else
      calculation = "Time"
      value = calc_time(@attributes)
    end
    puts "The " + calculation + " is: " + value.to_s
  end

  private
    def calc_future_value(params)
      puts 'Calculating Future Value:'
      future_value = params['present_value'] * ( (1.0 + params['rate'])**params['time'] )
      return future_value
    end

    def calc_present_value(params)
      puts 'Calculating Present Value:'
      present_value = params['future_value'] / ( (1.0 + params['rate'])**params['time'] )
      return present_value
    end

    def calc_rate(params)
      puts 'Calculating Rate:'
      rate = ( (params['future_value'] / params['present_value']) ** ( 1.0 / params['time'] ) )- 1.0
      return rate
    end

    def calc_time(params)
      puts 'Calculating Time:'
      time = Math.log(params['future_value']/params['present_value']) / Math.log( 1.0 + params['rate'])
      return time
    end

end

input = {'future_value' => 34, 'present_value' => 50000, 'rate' => 4, 'time' => 18}
PresentFutureValue.new(input).calculate
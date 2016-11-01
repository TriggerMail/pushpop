class KeenParser
  def initialize(response)
    @response = response
  end

  def last_two_weeks()
    [@response[-2]["value"], @response[-1]["value"]]
  end

  def percent_change()
    data = last_two_weeks()    
    results = []
    data[0].zip(data[1]).each do |week_ago, now|
      if week_ago["partner"] == now["partner"]
        recent_result = now["result"] || 0
        week_ago_result = week_ago["result"] || recent_result
        results.push({
          "partner" => week_ago["partner"],
          "result" => recent_result - week_ago_result 
        })
      end
    end
    results
  end
end

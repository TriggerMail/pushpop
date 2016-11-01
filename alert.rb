ENV["KEEN_PROJECT_ID"] = "57b2150e3831440a0a2ff20e"
ENV["KEEN_READ_KEY"] = "dbcfeac13a45c5c5bbaf6027ddcfa515f65c7cc12557d8e57744171d1dc9d7e8a2deb96dfa076635760ea2546ec13c3e275317b21e0e50f2bd7e87122a19667077abff068025cc0ccf43ed0d8a00f9871a6eb75bb812f8a30ee1786e24e80a9b"
ENV["SLACK_WEBHOOK_URL"] = "https://hooks.slack.com/services/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"

require "pushpop"
require "pushpop-keen"
require "pushpop-slack"
require "yaml"
require "./helpers.rb"

queries = YAML.load_file("./keen.yaml")
queries["queries"].each do |query|
  job do
  
      keen do
        event_collection    query["event_collection"]
        analysis_type       query["analysis_type"]
        timeframe           query["timeframe"]
        target_property     query["target_property"]
        group_by            query["group_by"]
        interval            query["interval"]
        filters             [{ property_name: query["filter"][0],
                               operator: "eq",
                               property_value: query["filter"][1] }]
      end
  
      step do |response|
        parser = KeenParser.new(response)
        over_threshold = []
        parser.percent_change.each do |partner|
          if partner["result"] > 20
            over_threshold.push(partner)
          end
        end
        over_threshold.sort_by{ |hsh| hsh["result"] }.reverse!
      end
  
      step do |response|
        if response.length > 0
          content = ""
          response.each do |partner|
            content += "#{partner["partner"]}: +%#{partner["result"].round(2)}\n"
          end
          {
            "fallback" => "#{query["name"]} data integrity",
            "text" => content
          }
        end
      end
  
      slack do |response|
        if response
          username "bluebot"
          message "[#{query["name"].capitalize}](https://www.bluecore.com/admin/data-analysis-dashboard/data_integrity)"
          icon "https://avatars.slack-edge.com/2015-10-27/13332011316_15716c9a1765d1a46b09_192.jpg"
          attachment response
        end
      end
  
  end
end

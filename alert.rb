ENV['KEEN_PROJECT_ID'] = '57b2150e3831440a0a2ff20e'
ENV['KEEN_READ_KEY'] = 'dbcfeac13a45c5c5bbaf6027ddcfa515f65c7cc12557d8e57744171d1dc9d7e8a2deb96dfa076635760ea2546ec13c3e275317b21e0e50f2bd7e87122a19667077abff068025cc0ccf43ed0d8a00f9871a6eb75bb812f8a30ee1786e24e80a9b'
ENV['SLACK_WEBHOOK_URL'] = 'https://hooks.slack.com/services/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'

require 'pushpop'
require 'pushpop-keen'
require 'pushpop-slack'

  job do
    keen do
      event_collection   'test_zahi_send'
      analysis_type      'extraction'
      timeframe          'last_240_hours'
    end
    slack do |response, _|
      puts      response
      message   "#{response}"
    end
  end

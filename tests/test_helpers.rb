require "./helpers.rb"
require "test/unit"

class TestKeenParser < Test::Unit::TestCase

  def test_last_two_weeks()
    response = [
      { "value" => [1, 2, 3] },
      { "value" => [4, 5, 6] },
      { "value" => [7, 8, 9] }
    ]
    parser = KeenParser.new(response)
    assert_equal(parser.last_two_weeks, [[4, 5, 6], [7, 8, 9]])
  end

  def test_percent_change()
    response = [
      { "value" => [{
          "partner" => "coco", 
          "result" => 10.23 
        }]
      },
      { "value" => [{
          "partner" => "coco",
          "result" => 5.12
        }]
      }
    ]
    parser = KeenParser.new(response)
    assert_equal(
      parser.percent_change, 
      [{"partner" => "coco", "result" => 5.12 - 10.23}]
    )
  end

end

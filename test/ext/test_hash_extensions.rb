require "#{File.dirname(__FILE__)}/../test_helper"

class TestHashExtensions < Test::Unit::TestCase
  def test_to_querystring
    args = {
      :action => 'get_auth_token',
      :api_key => 'rrc1d3ntb53tt6b2vhail6rdtrsxov3v',
      :ticket => 'udd863k39gn9mioc6ym2c6erbqm8q'
    }

    expected = 'action=get_auth_token' +
               '&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v' +
               '&ticket=udd863k39gn9mioc6ym2c6erbqm8q'
    
    actual = args.extend(Rubox::HashExtensions).to_querystring

    assert_equal expected, actual
  end
end

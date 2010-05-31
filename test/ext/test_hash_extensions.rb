require "#{File.dirname(__FILE__)}/../test_helper"

class TestHashExtensions < Test::Unit::TestCase
  def test_to_querystring
    args = {
      :action => 'get_auth_token',
      :api_key => 'rrc1d3ntb53tt6b2vhail6rdtrsxov3v',
      :ticket => 'udd863k39gn9mioc6ym2c6erbqm8q'
    }

    result = args.extend(Rubox::HashExtensions).to_querystring
    assert(result =~ /action=get_auth_token/, 'action')
    assert(result =~ /api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v/, 'api_key')
    assert(result =~ /ticket=udd863k39gn9mioc6ym2c6erbqm8q/, 'ticket')
  end
end

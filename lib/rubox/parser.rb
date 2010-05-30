require "xmlsimple"

module Rubox
  class Parser
    def initialize(response)
      @xml = XmlSimple.xml_in(response, 'ForceArray' => false)
    end

    def get_ticket
      @xml['ticket'].to_s
    end

    def get_auth_token
      @xml['auth_token'].to_s
    end

    def logout
      'logout_ok' == @xml['status'].to_s ? true : false
    end

    def register_new_user
      'successful_register' == @xml['status'].to_s ? true : false
    end

    def verify_registration_email
      'email_ok' == @xml['status'].to_s ? true : false
    end

    def get_account_info
      User.load_from_xml(@xml)
    end

    def get_account_tree
      root = @xml['tree']['folder']
      Folder.build_from_xml(root)
    end
  end
end

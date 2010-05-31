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
      Folder.build_from_xml(@xml['tree']['folder'])
    end

    def create_folder
      'create_ok' == @xml['status'] ? true : false
    end

    def move
      's_move_node' == @xml['status'] ? true : false
    end

    def copy
      's_copy_node' == @xml['status'] ? true : false
    end

    def rename
      's_rename_node' == @xml['status'] ? true : false
    end

    def delete
      's_delete_node' == @xml['status'] ? true : false
    end

    def get_file_info
      Info.build_from_xml(@xml['info'])
    end

    def set_description
      's_set_description' == @xml['status'] ? true : false
    end
  end
end
